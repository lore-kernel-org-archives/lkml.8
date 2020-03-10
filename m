Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3553C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46E9205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgCJVWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:22:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:56302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgCJVWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:22:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9F294AFDF;
        Tue, 10 Mar 2020 21:21:58 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, yangerkun <yangerkun@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 08:21:49 +1100
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
In-Reply-To: <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
References: <20200308140314.GQ5972@shao2-debian> <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org> <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com> <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org> <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org> <87blp5urwq.fsf@notabene.neil.brown.name> <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org> <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com> <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org> <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org> <878sk7vs8q.fsf@notabene.neil.brown.name> <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
Message-ID: <875zfbvrbm.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10 2020, Jeff Layton wrote:

>> @@ -735,11 +723,13 @@ static void __locks_wake_up_blocks(struct file_loc=
k *blocker)
>>=20=20
>>  		waiter =3D list_first_entry(&blocker->fl_blocked_requests,
>>  					  struct file_lock, fl_blocked_member);
>> -		__locks_delete_block(waiter);
>> +		locks_delete_global_blocked(waiter);
>> +		waiter->fl_blocker =3D NULL;
>>  		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
>>  			waiter->fl_lmops->lm_notify(waiter);
>>  		else
>>  			wake_up(&waiter->fl_wait);
>> +		list_del_init(&waiter->fl_blocked_member);
>
> Are you sure you don't need a memory barrier here? Could the
> list_del_init be hoisted just above the if condition?
>

A compiler barrier() is probably justified.  Memory barriers delay reads
and expedite writes so they cannot be needed.

 			wake_up(&waiter->fl_wait);
+		/* The list_del_init() must not be visible before the
+		 * wake_up completes, the the waiter can then be freed.
+		 */
+		barrier();
+		list_del_init(&waiter->fl_blocked_member);

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5oBO0ACgkQOeye3VZi
gblwqQ/8DkoZJyjuip/ioeNV4RJRreBlvckVZvhMWegAEcWtiVd5cIxwwz8R4C/Q
Wjqpyxw9g2jzlhbwNfjQwgQqVyWppGrzjhWlIDD5Js6nE8BKTBFtaWpcFsfZ6CX+
xieFoX0DIVAqqqJZPY2GaJZ11PUtJMHmr+/nDz2IdQNEcZuu34V1z+kTFzYyXevm
4lEy/8e5c16/lRID0fB4kk3RkcrM3DMnvONExpW2jqK0MrDMoTkxbLhhtMKONj0j
qDYCe7sV7+h9dxGA5WFWxvbt6l4n6epnNa5pKqihLtFqi85jGTygbca3V8W8YDM6
inrX9L+EduuK0VBP21sWc0k1YZTF3xCt+uVTLM/qROevkxivD6vWCB2XdAqNbnoj
raxEz15GEoMqAUlaPQ73hpvMfeAaeXVEm9gsgp7LjzoyQzL7F6rk5xQ/ccRo4cK2
zEoGnAt9kXQpobSfjnOELoFbzEFshSxzwQuEzmeh8fe7z84qjMVBl2kJOcL2XJ0N
dv2jiyG46DPl1ALm9EAVv4qlcwmOe4vklq087STWgGbAJTlzj+Q6SayXyOAwdzK+
RRxyvjEcPfS0xivpE2l0FkU/zjcg+A1HkSG94KPEP4xjLalfevU68H3BoSCfuGr2
PueecWCIamfD9nVunUqyawXWxdPISUKNrgq1sqQ2J8exnpUqMIU=
=ZHtk
-----END PGP SIGNATURE-----
--=-=-=--
