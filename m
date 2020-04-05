Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150DEC2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ED220644
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hR4XYDoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgDETGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:06:25 -0400
Received: from mout.web.de ([217.72.192.78]:41709 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgDETGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586113573;
        bh=F9t6N3Mi4poOQ1g76zkCvSdBvDzShiTzIKtgmQuU3aI=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=hR4XYDoqSnED5nHpTBqBYKpNt88eGsHFqnTpFaf2xK1fsw9O42dOJMv4ECAbld8u/
         xew1s1c/3qkMwEm21P/lhOj0Mzqb1m8aeg+xrrQU34DlgmFOq2yumjCR1O8LXjs/c5
         z2MRA3SAy20yDhbbxcprjVOWecZvbMZupMh5Y/mM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.99.70]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1G68-1j1ZNd1OMS-00tF2B; Sun, 05
 Apr 2020 21:06:13 +0200
To:     Qiujun Huang <hqjagain@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] powerpc/powernv: add NULL check after kzalloc in
 opal_add_one_export
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d4a96597-6704-3030-b936-6282f0994f09@web.de>
Date:   Sun, 5 Apr 2020 21:06:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R5F9cXQvCKRzVq8oaRBgCbtQfWlSVhukcrw1bBjAL3pP1En1Uvm
 HgmJ+jsDIFJAmpWjk42WpQPGcdDa5/Ek2G50g6T0Y4tIxAQRZ1tpl4fEaSzoruRn1DUprCZ
 aFNSKGIxrKrCWrnXCmpCbG5kosOQJWJLOsizdF/8TJMfKOYakLS4SMgxg+yrgfRX4NL26Uj
 YUgQSyTWgnYZ9Z1fWiq1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PbZRXBLTfsw=:HN2105tXExuzk+NvXgPqaJ
 IkV3ZUEA076oCGpbjeGuV5luhkX6bEdwKneTKQA5xyybdaE3R0roSqckFdi4y+aFBMD7mRggt
 ayOI5WpHyZN09JEe7xAW3UU7tg52xTHXnIik5/AW3on06YFuv7SxmiplnPbcVE6VZdV7+80dT
 GFnjuJWA0XNYW5ivsQfLhYHenO4ljw0qYRNtySIxqr78oHJvDLQcDJrEhUchYVDsqTpd8HmTB
 T9dr2MlLbk+NLgLzGsfhrVjjuCSzWwP72mu1QfVyv60zYbPvUoH2FwLaKmQHolTUWVCO3rru1
 Z7eaPgvwGCCkjP6wAAdLoTz3se/Ytp1aU/asDcGmz45V0FX8DzUQkLZk+XOdBdDKy6APY/Oz8
 B5qOdwu3HI+Jxt0EWoZvXqwjDAUlGT4nGsLDbbYlMdTzVGFP0rhCfpnQ8I45PadjSMmqiviiM
 XGjgIphuEnAJV2yckP9gUDKXAY7wo4RuAFsgB3D8Vi2Qjtz0BRyXoyQ9XU8MbRtcdzYKOPgwz
 GqmqHlrp3UUTSLmxJo3BToxBrqG+LfYws19EyXmurl1S5BMwhOSN2ve1/0TtnJJ//rAU3zWfz
 N/cdYHNlVNwwVSGml7OoELtz95VKEAQdFg3zMC/mMp9rFxKvatlnaSVcjE0W8JevnXvgTb7mh
 qYesxixrFfWzwykTUBrfFIRsPwX4Tq42SWr6ZnGFwtqzJjqPV2IohE+GoOx7K6uTxSMYSLTwX
 vnj2mwn9vuqZffQ46t50sXUcl/dNYYPwnvT5bdPRXzXaNUdgBNtNZTKYEXTaHeXvp5CflK3+7
 Hr/+Ry2Jy5orreoF6SmJ16KHaTk2XwIP7z7DnerP9GGaJcTbzQtXqWSQZAdhDnpCFI5RdVZCL
 lE22ajGsV0E1jlNACx9gGVfaymgVDq6ztmgB3AntV6M1+R1VyaOalNBhJXCJJnkXGMINjCnxb
 xBhTjvw7TfYZxLs3yLg5AfNLqYDPBQVGQ09XudzOayxF22Zj5rB12UgyKUlFTgJraOGJGb9Vn
 o4xSgYs/7ob4ywvnttOGjLzoWChtqKYXgkKyaTpCHzi7xzRoiDCTMNp0duK4RnV0EqyQzC+Hu
 uczTmyfauoWD4WvGZx+Hg2WoCHXlBEToqwesNTtoVSrm9LyzD1x2ba1qMyx7bBEqyA3sBgWnd
 QXeT5Qz1hKPozvILqdgQ047RSypWCYq6t72GafJ2JV6TmzpB18Khkb/rIkJUolDPSD7inTrq4
 BPOHu5dRl4DDo8EA9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Here needs a NULL check.

I find this change description questionable
(despite of a reasonable patch subject).


> Issue found by coccinelle.

Would an information like =E2=80=9CGenerated by: scripts/coccinelle/null/k=
merr.cocci=E2=80=9D
be nicer?


> ---

Will a patch change log be helpful here?

Regards,
Markus
