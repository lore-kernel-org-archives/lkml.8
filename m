Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A285207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFhT6Jm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgCEStN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:49:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44026 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCEStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:49:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id c144so3182677pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=yeojKfs+DIF50e2z9lTK1rV3mSPm2muGlf6W6Jtrj1M=;
        b=eFhT6Jm9QiJjGvszIGgJU3LDtokueYoMPRdjkC4rIVdm766aIAyJLb1vBcI+JHOdd5
         TDvRUT3ondUtbv7qt7iVldnJYZSfv1SPjQm8Vwg/BIOnJMIq+AihYTSLfvrFNNNteFTr
         pfi2HIQxFdIUmP1WPSCTfwaoAAliKwqpbavd+Lar/l740YUkc0EPwWnDxzgFxH2UQv2P
         enk3Xqw22u979l+2jfKnx2CRF9++vHtbGLiKEsQXZDJpulzGfX/kYd56aZSsNCZNyHRI
         SeQD9vm79xLe55VAcChoYgtIXGIlupDEWzu4aB7itSqsVD/QfIVRPn8QDuaHHPacM1+E
         W8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yeojKfs+DIF50e2z9lTK1rV3mSPm2muGlf6W6Jtrj1M=;
        b=CzZNk6KgXT3TsppYerQqb1m8ul7Rml+41yKVBztC16bYuYfUpeVVYsusbTnahu5mod
         TVWGvtAHPWQ5TVdGIWDpvpRvwKAKtjX6vlyeFi6RKbtNJ2UXtOyRboNuBeD4zdhgY5Aq
         0WhSaxJXDCccVC8IBnTOaTUd11+FO1rPdCSUt0ebOo/5IWwl24hcmm0Y1QdVWGpsSSjI
         HTDKiUrIllL+R2XRpTeAIpKEWRHXTjF7qt2PNy71iCGIPz9mDGs84RSNPSoSHeXP2Ii2
         LBWaL+tvkJOw6Sa9csrBsoC4VQwAUFiLhqruk5zDJqZItPE3t0KNebYNhF6saJ4Fmktb
         QFtg==
X-Gm-Message-State: ANhLgQ2+m+C7aiK0c3m4WiVD/GjKLUMIEohF5OhvtxIoSzqIVlbuQDpl
        v1ygGO7YewoXKbeizvxzMeAg5w==
X-Google-Smtp-Source: ADFU+vu71eFAcd4Zsz7IMC7zWPkXrM15Q1FhzsmI0GUizf4IaBEDEviTpSNDLaciV9H85v91pCe7Qw==
X-Received: by 2002:a62:3808:: with SMTP id f8mr9823447pfa.30.1583434150025;
        Thu, 05 Mar 2020 10:49:10 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id q30sm4159690pjh.5.2020.03.05.10.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:49:09 -0800 (PST)
Date:   Thu, 05 Mar 2020 10:49:09 -0800 (PST)
X-Google-Original-Date: Thu, 05 Mar 2020 10:49:04 PST (-0800)
Subject:     Re: [PATCH v2 0/4] QEMU Virt Machine Kconfig option
In-Reply-To: <CAAhSdy0=NHHVvJed733nK+FkprfQ5j7puw1RtsD3Xtg4s2vQjQ@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     anup@brainfault.org
Message-ID: <mhng-fd0e8412-09d7-4662-aa90-c6ece9bf4b31@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 19:22:38 PST (-0800), anup@brainfault.org wrote:
> Hi Palmer,
>
> On Tue, Dec 3, 2019 at 9:19 AM Anup Patel <Anup.Patel@wdc.com> wrote:
>>
>> This patch series primarily adds QEMU Virt machine kconfig opiton and
>> does related RV32/RV64 defconfig updates.
>>
>> This series can be found in riscv_soc_virt_v2 branch at:
>> https//github.com/avpatel/linux.git
>
> The corresponding QEMU patches are now part of QEMU upstream
> master branch.
>
> Can you consider this series for Linux-5.6 ??

They're on fixes.

>
> Regards,
> Anup
>
>>
>> Changes since v1:
>>  - Fixed commit description in PATCH2
>>  - Rebased series on latest Linus's master branch at
>>    commit 76bb8b05960c3d1668e6bee7624ed886cbd135ba
>>
>> Anup Patel (4):
>>   RISC-V: Add kconfig option for QEMU virt machine
>>   RISC-V: Enable QEMU virt machine support in defconfigs
>>   RISC-V: Select SYSCON Reboot and Poweroff for QEMU virt machine
>>   RISC-V: Select Goldfish RTC driver for QEMU virt machine
>>
>>  arch/riscv/Kconfig.socs           | 24 ++++++++++++++++++++++++
>>  arch/riscv/configs/defconfig      | 17 +++--------------
>>  arch/riscv/configs/rv32_defconfig | 18 +++---------------
>>  3 files changed, 30 insertions(+), 29 deletions(-)
>>
>> --
>> 2.17.1
>>
