Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4441CC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1272C2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgV/NvX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDJMCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:02:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38204 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726111AbgDJMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 08:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586520166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=4PV78bAk+hlt89+W5fC7otBNMe9otSO/WxE1vj8UtsE=;
        b=JgV/NvX/xt/NafwVUOqIIl0R9UGsROakJ3V1a3F/oxH86P6oDUx9A6tKmQiqYZPPOLpUDW
        dRbhA7r15LghRq/Ob/By8jziX6druxf7w8CpnI8AEkmC4Sz7P/cAOB0tkDR5sZy1CS52WL
        PfUeCjM7xtqAUugTw5Ei+iw6IweLZBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-uhkYjV31Nai_cTjjKe-LKw-1; Fri, 10 Apr 2020 08:02:40 -0400
X-MC-Unique: uhkYjV31Nai_cTjjKe-LKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 036C9801E5E;
        Fri, 10 Apr 2020 12:02:39 +0000 (UTC)
Received: from [10.10.112.152] (ovpn-112-152.rdu2.redhat.com [10.10.112.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 549E0272D3;
        Fri, 10 Apr 2020 12:02:10 +0000 (UTC)
Subject: Re: [PATCH] Documentation: hugetlb: Update hugetlb options
To:     Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200409215800.8967-1-peterx@redhat.com>
 <ba5c87df-9a77-ebd2-e45e-f262a36fbf22@oracle.com>
 <20200409221819.GA3172@xz-x1>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <868dc6b9-2382-b71d-5aca-495556822f99@redhat.com>
Date:   Fri, 10 Apr 2020 08:02:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409221819.GA3172@xz-x1>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XX3LHd7zDBxhmLrNQOUjvx4itH37pD96f"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XX3LHd7zDBxhmLrNQOUjvx4itH37pD96f
Content-Type: multipart/mixed; boundary="xfKz3uFXp7nJsQ2dqdkb9lTu8fJw6tjK7"

--xfKz3uFXp7nJsQ2dqdkb9lTu8fJw6tjK7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 4/9/20 6:18 PM, Peter Xu wrote:
> On Thu, Apr 09, 2020 at 03:08:07PM -0700, Mike Kravetz wrote:
>> On 4/9/20 2:58 PM, Peter Xu wrote:
>>> The hugepage options are not documented clearly.
>>>
>>> Firstly, default_hugepagesz=3D should always be specified after the
>>> declaration of the same type of huge page using hugepagesz=3D.  For
>>> example, if we boot a x86_64 system with kernel cmdline
>>> "default_hugepagesz=3D2M", we'll get a very funny error message:
>>>
>>> "HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 2097152"
>>>
>>> It's understandable from code-wise because when hugetlb_init() we
>>> didn't have the 2M page hstate registered, so it's unsupported.
>>> However 2M is actually the default huge page size on x86_64, so we'll
>>> register it right after the error message.  However it's very
>>> confusing if without these knowledges.
>>>
>>> Secondly, hugepages=3D option must be used _after_ another hugepagesz=
=3D.
>>> The word "interleave" is fine but it didn't declare the fact that
>>> each of the hugepages=3D option will be applied to the previous parsed
>>> hugepagesz=3D option.
>>>
>>> State all these clear.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> Hi Peter,
>>
>> Did you happen to see this patch series?
>>
>> https://lore.kernel.org/linux-mm/20200401183819.20647-1-mike.kravetz@ora=
cle.com/
>>
>> That should address the documentation issue and more.
> Great!
>
> I missed that, but I'll definitely read it (probably tomorrow).  Let's
> ignore this patch then.

My bad, I didn't realize that Mike has already=C2=A0 pointed you in the rig=
ht direction.
Please ignore my earlier email. :)

>
> Thanks,
>
--=20
Nitesh


--xfKz3uFXp7nJsQ2dqdkb9lTu8fJw6tjK7--

--XX3LHd7zDBxhmLrNQOUjvx4itH37pD96f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl6QYEEACgkQo4ZA3AYy
ozmSGQ//bd7RChKa2V6CNF6FFwIl+F5Qvfu0h9W3XP5e/vzCo74Z91ePgTYyvj7F
1DdczHzN/14YswNVMkcete38Ibj8v5FuLZMndE9tcXmedLxcvKAv3Rke2s9RNYHZ
Sh3eFXdhHLGYwGcGFHEa0mxe+wNfm9Xc3DQ0wv37bQ1GSZmd2qEa7eXClgAw2W7a
O7M/KyP/ebcyRxAA1sJQLc4bRkk2MHBrFlamYtgpT/6lakH6RhYzwBO+e1T4dOnM
YiLa+tAgsP4JcbHrSA7KGF6KqFAIWrzuhI84cE4x0npaBWhBGSwBtka7YzT3HJzr
VpBVrjTHBJD+VCglypNmyuFwufopRsgr8RFZWd4UTimICvFP1iATIeSYfE8mRgi9
Onz9ONczv2z1RaxO2NVSp1k5D0sMxIKtGsITHJ47lOh9sM/AF/1FFb8j3qnv4Yvb
UA9qCaW9u+6eiRAZRwwiqmwMXe0tss234ouZ34BuNzAmIGkjh/86/6QTcWLIsPPw
Wxx91xz3JCJgoFoZud76EY2lUUQQCs7Y7UnyuQ6P8n0kmXHT91h45cqC/7YPZQkt
VGEuzCD8s0NSpnd/sX2SXTC2hSzpjCGmcZq1uwfYPndnkpYlBVjNSH5B7doj5h5N
RyvbPQNkaRYqAnApSNoecb1NgmKKtoarCV/i75Y7crrlxU9CJ64=
=E+fl
-----END PGP SIGNATURE-----

--XX3LHd7zDBxhmLrNQOUjvx4itH37pD96f--

