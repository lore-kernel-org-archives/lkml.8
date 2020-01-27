Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7658F22527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgA0Rdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:33:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:34674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgA0Rdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:33:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50032AC53;
        Mon, 27 Jan 2020 17:33:38 +0000 (UTC)
Date:   Mon, 27 Jan 2020 18:33:36 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20200127173336.GB17425@blackbody.suse.cz>
References: <alpine.DEB.2.21.1912041524290.18825@www.lameter.com>
 <20191204153225.GM25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041652410.29709@www.lameter.com>
 <20191204173224.GN25242@dhcp22.suse.cz>
 <20200106115733.GH12699@dhcp22.suse.cz>
 <alpine.DEB.2.21.2001061550270.23163@www.lameter.com>
 <20200109145236.GS4951@dhcp22.suse.cz>
 <20200109114415.cf01bd3ad30c5c4aec981653@linux-foundation.org>
 <20200117171331.GA17179@blackbody.suse.cz>
 <20200118161528.94dc18c074aeaa384200486b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20200118161528.94dc18c074aeaa384200486b@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 18, 2020 at 04:15:28PM -0800, Andrew Morton <akpm@linux-foundation.org> wrote:
> > situations, the udev events seem to cause useless tickling of udevd.
> > [...]
> > and I drew the following ballpark conclusion:
> > 1.7% CPU time at 1 event/s -> 60 event/s 100% cpu
> Thanks.  What effect does this patch have upon these numbers?
When I rerun the script with patched kernel, udev sit mostly idle (there
were no other udev event sources). So the number can be said to drop to
0% CPU time / event/s.

> Typically the author, but not always.  If someone else is particularly
> motivated to get a patch merged up they can take it over.
Christopher, do you consider resending your patch? (I second that it
exposes the internal details (wrt cgroup caches) and I can observe the
just reading the events by udevd wastes CPU time.)


Thanks,
Michal

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl4vHuoACgkQia1+riC5
qSglHw/+OsFYcoJy3FzkbfwtOd2tJfVaDTpasyXswReAFnBRnJmkYbcuaZbFBn6e
C98PumV6RYN+Etv7n1RTqxcgj6QCki4kMqNYD758IJqIExsXue9ftCTfwF9iG3CQ
DUgppdSbCXdE04oprliEQs7EhY+d6X/Ln5ENZaNTVgXXOjVcAvH5vaiRFfMFyhno
+0CsE77seYzs2LjgaS4zcb5FhjhOd3QJ7E0ZdKadnsRpLQ7NqqEsItAOiWBPoqXU
118kbFzjjf84nA7IyH+G34K0XSslmBUzOb3wkjSpTOd6ZuQ3FhPw3Q705PRHrYKM
rY8qet8C9/hfHs9Qq/Io/RwZv+2M3J7+DN4o/F4lyZgRb1FNaixZMe4lbGGr6TT3
c9ck2izlt42kT9MqMnHov7qvhI9nkERaCbJ+Xv7BPRRtF/aMH2KYiSucXHRjQh8L
45YOPArLRLzbPYcq/KmDYbCT36yFWrfphOk8iTu2XjjcdXvpcZauAAGJVOyUxDK7
0KL4C9AkkQEhrVs8AI5u6u08jeajbu71R7zopg+2CI34qGco4d63v7hLKxO8CopS
N0VUmr+zv6VfPbeGPMPJfsTuZmE6g+14CbKl1DWSdNshlohuyyws5DjruNYEGKvF
59XBuK0JzZ0txSzj5srtLUBtzUwOGdaNS5dJqRXIryV1UpeYPaM=
=CZSY
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
