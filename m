Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA011C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A995920748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HEehV5TE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgEUUkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:40:41 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8058 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgEUUkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:40:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec6e6f80000>; Thu, 21 May 2020 13:39:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 May 2020 13:40:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 May 2020 13:40:40 -0700
Received: from [10.2.48.182] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 May
 2020 20:40:39 +0000
Subject: Solved: [PATCH 0/4] mm/gup, drm/i915: refactor gup_fast, convert to
 pin_user_pages()
From:   John Hubbard <jhubbard@nvidia.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20200519002124.2025955-1-jhubbard@nvidia.com>
 <159008745422.32320.5724805750977048669@build.alporthouse.com>
 <b907c1d5-b95a-3d00-cafa-0a321f0141d8@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <7d79c089-7b21-cf7f-66ea-078d44c5e007@nvidia.com>
Date:   Thu, 21 May 2020 13:40:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b907c1d5-b95a-3d00-cafa-0a321f0141d8@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590093560; bh=R00sEmekZJ8u338i/al5pR/bnMoqlwFIj15sC5O7Tb0=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HEehV5TEO95q9SZZIw94tj9i8A1ZHRKg/VVw2mM1WbQii8ZoxWDLYpPGI8JZlmyTE
         bHp0aCT2uYsQTO30z0juH470+/qQiTLEOl76kEibLolBDUxvBjyH28W5YWkuGp02BN
         Hdmsc8q6FKDac9PYGELJ/3wJK6IiwGHGgN+Et2XA70z51BIE7ubIHSLvisNG9Vs1yx
         +lzHxw+OtEJEzSUk6opuAjcCHpYlwiBayNhAwGWOJGIBESU1Vcee8UjNwpYFwG3INr
         2isZCbqFqafbsyQl+cXjBrlG+X+72PTLeCFFpHGWD8n7M6ApU7d7IJXQeJXeYcDfRG
         cE+N7LFn2e0MQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-21 12:11, John Hubbard wrote:
> On 2020-05-21 11:57, Chris Wilson wrote:
>> Quoting John Hubbard (2020-05-19 01:21:20)
>>> This needs to go through Andrew's -mm tree, due to adding a new gup.c
>>> routine. However, I would really love to have some testing from the
>>> drm/i915 folks, because I haven't been able to run-time test that part
>>> of it.
>>
>> CI hit
>>
>> <4> [185.667750] WARNING: CPU: 0 PID: 1387 at mm/gup.c:2699=20
>> internal_get_user_pages_fast+0x63a/0xac0


OK, what happened here is that it's WARN()'ing due to passing in the new
FOLL_FAST_ONLY flag, which was not added to the whitelist.

So the fix is easy, and should be applied to the refactoring patch. I'll
send out a v2 of the series, which will effectively have this applied:


diff --git a/mm/gup.c b/mm/gup.c
index 6cbe98c93466..4f0ca3f849d1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2696,7 +2696,8 @@ static int internal_get_user_pages_fast(unsigned long=
 start,=20
int nr_pages,
  	int nr_pinned =3D 0, ret =3D 0;

  	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
-				       FOLL_FORCE | FOLL_PIN | FOLL_GET)))
+				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
+				       FOLL_FAST_ONLY)))
  		return -EINVAL;

  	start =3D untagged_addr(start) & PAGE_MASK;


>> <4> [185.667752] Modules linked in: vgem snd_hda_codec_hdmi snd_hda_code=
c_realtek=20
>> snd_hda_codec_generic i915 mei_hdcp x86_pkg_temp_thermal coretemp snd_hd=
a_intel=20
>> snd_intel_dspcfg crct10dif_pclmul snd_hda_codec crc32_pclmul snd_hwdep s=
nd_hda_core=20
>> ghash_clmulni_intel cdc_ether usbnet mii snd_pcm e1000e mei_me ptp pps_c=
ore mei=20
>> intel_lpss_pci prime_numbers
>> <4> [185.667774] CPU: 0 PID: 1387 Comm: gem_userptr_bli Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0 U           =20
>> 5.7.0-rc5-CI-Patchwork_17704+ #1
>> <4> [185.667777] Hardware name: Intel Corporation Ice Lake Client Platfo=
rm/IceLake=20
>> U DDR4 SODIMM PD RVP, BIOS ICLSFWR1.R00.3234.A01.1906141750 06/14/2019
>> <4> [185.667782] RIP: 0010:internal_get_user_pages_fast+0x63a/0xac0
>> <4> [185.667785] Code: 24 40 08 48 39 5c 24 38 49 89 df 0f 85 74 fc ff f=
f 48 83 44=20
>> 24 50 08 48 39 5c 24 58 49 89 dc 0f 85 e0 fb ff ff e9 14 fe ff ff <0f> 0=
b b8 ea ff=20
>> ff ff e9 36 fb ff ff 4c 89 e8 48 21 e8 48 39 e8 0f
>> <4> [185.667789] RSP: 0018:ffffc90001133c38 EFLAGS: 00010206
>> <4> [185.667792] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88=
84999ee800
>> <4> [185.667795] RDX: 00000000000c0001 RSI: 0000000000000100 RDI: 00007f=
419e774000
>> <4> [185.667798] RBP: ffff888453dbf040 R08: 0000000000000000 R09: 000000=
0000000001
>> <4> [185.667800] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88=
8453dbf380
>> <4> [185.667803] R13: ffff8884999ee800 R14: ffff888453dbf3e8 R15: 000000=
0000000040
>> <4> [185.667806] FS:=C2=A0 00007f419e875e40(0000) GS:ffff88849fe00000(00=
00)=20
>> knlGS:0000000000000000
>> <4> [185.667808] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> <4> [185.667811] CR2: 00007f419e873000 CR3: 0000000458bd2004 CR4: 000000=
0000760ef0
>> <4> [185.667814] PKRU: 55555554
>> <4> [185.667816] Call Trace:
>> <4> [185.667912]=C2=A0 ? i915_gem_userptr_get_pages+0x1c6/0x290 [i915]
>> <4> [185.667918]=C2=A0 ? mark_held_locks+0x49/0x70
>> <4> [185.667998]=C2=A0 ? i915_gem_userptr_get_pages+0x1c6/0x290 [i915]
>> <4> [185.668073]=C2=A0 ? i915_gem_userptr_get_pages+0x1c6/0x290 [i915]
>>
>> and then panicked, across a range of systems.
>> -Chris
>>

btw, the panic seems to indicate an additional, pre-existing problem:
i915_gem_userptr_get_pages(), in this case at least, is not able to
recover from a get_user_pages/pin_user_pages failure.


thanks,
--=20
John Hubbard
NVIDIA
