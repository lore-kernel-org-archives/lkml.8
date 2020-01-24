Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F3CC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 00:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8E6206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 00:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SPMPAK0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgAXABQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:01:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46886 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgAXABQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 19:01:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so330002ljc.13;
        Thu, 23 Jan 2020 16:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oAqx0oDShqyWqmyWl5SVU9PFNePPKKqDHWCDLQ6fp2A=;
        b=SPMPAK0IfJobG635XYUTf+AMdgDP54jy1l3TM1JhI/p9vQalV6ibgIMPydP3nGH1P1
         03eoAL/jLJ1+Tp3IezQSWMfOZ3Ka7aEwzid0ojfktCARIrfBui/rhFkCYflu49IPXWqx
         A1XbcNCZdxmJ6sQFiJIE4za6aQy+a7GgSeWTbgJZHkJSxG/NyTP+SdZQYW3sB4JF64Pz
         8d9skalo0skiTalCfOGAPHzesmH+THzQGi7V41tGd0kYKRKfi6i6BwK6cqNX6dva5e/q
         pTkpri+ShlT1/fHeLnLfvV3OthnO5JafsgpzrdgpOGywh3khbH/v8Vh+LX94NXj3oa5z
         yHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oAqx0oDShqyWqmyWl5SVU9PFNePPKKqDHWCDLQ6fp2A=;
        b=Db+rsT7wlH67efVy2nKtWXHBPAEoXq8J82Z63vQfApySnmrc72cvjP1pUFRjGkZJIn
         oZuPw71ey691GO5zk23Z8fVLc6sBWSIL07ely7gV3LByfH9DuK7Ywad36jVDS4bDgVYc
         T0JHHPpIVv1VKdQ0zoA2GLY/i0d6YtDpZeJnB2VNpyrpq0hABSYsF2fXr0s0QtoxINy9
         iogolQEmtAyeAGsoFWNDGQ/WF4BgLKGeCTp5dCfB4EPlf1awKxg2c57OaCwvGCMYgML1
         S5ApxjbML4Q7sk+ekFzC944NAyUDRXfKovS+T2MswH+jcj6X97u4txltAb4hxcgsZR7L
         g60w==
X-Gm-Message-State: APjAAAXcsm520mVGCpuT9V/36Zwcjbl2eNDa70UfU0pLHhfpjmt7BNx5
        0GH/lhyuaeptcCvApuxCI8NAqx5vb6CTF2mC4DQ=
X-Google-Smtp-Source: APXvYqy3vv9feEMZb4RFFhjzPb6p7tyvMoxr04+eMD6zaoJXve4Cw3+nL7kx6D1chit/X17URnrHhGE4UYMOBtG9cQc=
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr531422ljl.56.1579824072889;
 Thu, 23 Jan 2020 16:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20200122160800.12560-1-linux@roeck-us.net> <20200122160800.12560-7-linux@roeck-us.net>
In-Reply-To: <20200122160800.12560-7-linux@roeck-us.net>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Fri, 24 Jan 2020 00:01:02 +0000
Message-ID: <CANVEwpbeT_O=4TZu7RuRupwOGTNEVWSnHXvMsEqEmeKqmu92jw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] hwmon: (k10temp) Add debugfs support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        =?UTF-8?Q?Ondrej_=C4=8Cerman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Darren Salt <devspam@moreofthesa.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

you asked else where for  debugfs files from machines with embedded
graphics. I've pasted diffs below (idle,load) from my 3400G ('Picasso' APU)=
.

On Wed, 22 Jan 2020 at 16:08, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Show thermal and SVI registers for Family 17h CPUs.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/k10temp.c | 78 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 1 deletion(-)
>
[snipping here for brevity]

--- svi-idle    2020-01-23 23:27:36.576177896 +0000
+++ svi-load    2020-01-23 23:33:05.342392957 +0000
@@ -1,8 +1,8 @@
-0x05a000: 0000000e 0000000e 00000002 01710000
-0x05a010: 014a0010 00000000 0000000e 00000000
-0x05a020: 00000000 00000000 00000080 005f0000
+0x05a000: 0000000e 0000000e 00000002 011f002e
+0x05a010: 014a0017 00000000 0000000e 00000000
+0x05a020: 00000000 00000000 00000080 001a0000
 0x05a030: 00000000 00000000 00000021 00000000
-0x05a040: 00000000 00000000 00000000 5f000000
+0x05a040: 00000000 00000000 00000000 1a000000
 0x05a050: 68000000 48000000 00000000 0000030a
 0x05a060: 00000007 00000000 80000002 80000002
 0x05a070: 80000041 00000001 00000008 00000000

--- thm-idle    2020-01-23 23:27:51.969229368 +0000
+++ thm-load    2020-01-23 23:33:19.779445923 +0000
@@ -1,15 +1,15 @@
-0x059800: 24200fef 00ff1001 00002921 000f4240
+0x059800: 3f800fef 00ff1001 00002921 000f4240
 0x059810: 800000f9 00000000 00000000 00000000
 0x059820: 00000000 00000000 00000000 0fff0078
-0x059830: 00000000 0029ccdf 0029acde 002a2ce2
-0x059840: 002a4ce3 002a0ce1 002a0ce1 002a6ce4
-0x059850: 0029ece0 0029ece0 002a0ce1 002a0ce1
-0x059860: 0029acde 002a8ce5 0029ece0 0029acde
-0x059870: 00298cdd 0029ece0 002a8ce5 002a4ce3
-0x059880: 0029ccdf 002a8ce5 0029acde 00296cdc
-0x059890: 002a4ce3 00296cdc 0029ece0 0029acde
-0x0598a0: 00294cdb 0029ece0 00294cdb 00298cdd
-0x0598b0: 0029acde 00000000 00002100 ffffffff
+0x059830: 00000000 0030cd17 002e8d05 002f4d0b
+0x059840: 00338d2c 0032cd26 00314d1b 0034cd36
+0x059850: 002d8cfd 002e2d02 00300d11 002eed08
+0x059860: 002dccff 002fcd0f 002d4cfb 002e0d01
+0x059870: 002ded00 002f2d0a 00346d33 00344d32
+0x059880: 002f8d0d 00346d33 002f4d0b 0030cd17
+0x059890: 00344d32 00302d12 0031ed20 00386d53
+0x0598a0: 00392d59 0036ad45 0036ed47 0034ad35
+0x0598b0: 0034ad35 00000000 00002100 ffffffff
 0x0598c0: 00000000 00000000 00000000 00000000
 0x0598d0: 00000000 00000000 00000000 00000000
 0x0598e0: 00000000 00000000 00000000 00000000
@@ -20,15 +20,15 @@
 0x059930: 00000000 00000000 00000000 00000000
 0x059940: 00000000 00000000 00000000 00000000
 0x059950: 00000000 00000000 00000000 00000000
-0x059960: 00000000 08400001 00004623 00000039
+0x059960: 00000000 08400001 00008241 00000045
 0x059970: c0800005 30c8680e 00024068 00000000
 0x059980: 00000000 00000000 00000000 00000000
 0x059990: 00000000 00000000 00000000 00000000
 0x0599a0: 00000000 00000000 00000000 00000000
 0x0599b0: 00000000 00000000 00000000 00000000
-0x0599c0: 00000060 000002a8 0000000c 00000294
-0x0599d0: 0000001b 00000000 00000000 000002a8
-0x0599e0: 0000000c 00000000 00000000 00000001
+0x0599c0: 00000060 00000392 0000001b 000002d4
+0x0599d0: 0000000d 00000000 00000000 00000392
+0x0599e0: 0000001b 00000000 00000000 00000001
 0x0599f0: 00000000 00010003 00000000 00000000
 0x059a00: 00000000 00000000 00000000 00000000
 0x059a10: 0000000e 00000000 00000003 00000000

and the accompanying human-readable sensor output
(these were not all taken at hte exact same moment)

--- k10-idle 2020-01-23 23:25:32.020740997 +0000
+++ k10-load 2020-01-23 23:33:01.305378146 +0000
@@ -1,15 +1,15 @@
 k10temp-pci-00c3
 Adapter: PCI adapter
-Vcore:        +0.96 V
-Vsoc:         +1.09 V
-Tdie:         +36.9=C2=B0C
-Tctl:         +36.9=C2=B0C
-Icore:        +2.00 A
-Isoc:         +5.75 A
+Vcore:        +1.34 V
+Vsoc:         +1.08 V
+Tdie:         +62.5=C2=B0C
+Tctl:         +62.5=C2=B0C
+Icore:       +56.00 A
+Isoc:         +6.75 A

 amdgpu-pci-0900
 Adapter: PCI adapter
 vddgfx:           N/A
 vddnb:            N/A
-edge:         +36.0=C2=B0C  (crit =3D +80.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
+edge:         +62.0=C2=B0C  (crit =3D +80.0=C2=B0C, hyst =3D  +0.0=C2=B0C)

Hope this is not a waste of your time.
Would you like similar for the 2500u ?

=C4=B8en
--=20
I live in a city. I know sparrows from starlings.  After that
everything is a duck as far as I'm concerned.  -- Monstrous Regiment
