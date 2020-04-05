Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C106FC2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 15:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985DD20659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 15:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1HdO4V8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgDEPaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:30:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33111 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgDEPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 11:30:35 -0400
Received: by mail-io1-f65.google.com with SMTP id o127so13027032iof.0;
        Sun, 05 Apr 2020 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yvEjNWR2BGZ2SH6akSfQFul9qgwv77tPLoJrdQcMpQg=;
        b=Q1HdO4V8WqRn9BOJTAzxFnuKHo80y5XF6qo/nQ3DPYkVBbiVrfG3UMOqC0xBCe68Ag
         jLpuZN4peqFkDZrJtuZ2lLGmTOPggYr7FqteZaMjhAyMhnigBybDchpQ3h2cRrlvCkCQ
         2Uy0WJVdtzncI7qCVGhK89q6iD+HbNXoOOU2qjWx0ouBcwdgNvWDvsHcNVcPqJsMzK5K
         1rkwnN9115YhhN63/f70BpwWfZJdSC/KLSlevLRjbumXjkPfH/Dmhdk1lHlZ/0Wa/vdV
         F5x4ppJ075vTZGJ5sq1gy5gk4hHG/ouUvt6cyflp/vw8gUmW61a5Vlb3HH4u6OTmLNfa
         Eswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yvEjNWR2BGZ2SH6akSfQFul9qgwv77tPLoJrdQcMpQg=;
        b=BG10j1CYiy7SgDedZ3fa+rkmT6z2lqsU/57O0SSxB9Q56a9nCfAruSMarnXKM0eRG+
         Y3Xo9QuaBKlLN5RbWJChpFsc6F2bcTGPuKBQywES0o5Bo+2p5uNaIUb0eqMYoselJ4Y+
         0Q4WJ6PoyPAitggH5QlNK9vU36GL7twDWvSgRotUvbaL5MBTf8mMfc76o9w7DN1HAYER
         xRjTdPpM5EYr1oAARNaMRxN3BrtD/jqhDEA4id8IY+a0qYg/sOU6LXZuDnT/ykFFY8om
         41MTfITSHU2+YHbQlp9QxYM3GGLK+qEcpK970U65a44aCSRNKfkORQuF/3VC7OLbGs3o
         0mwg==
X-Gm-Message-State: AGi0PubQ2uBK+s4wamw1FV58ir4jK7y0KvQnEQ/947FzdzMafoIyaA6J
        P++QSKyiff3KOrfDESZynKkx77yvNVANrMQeCM8=
X-Google-Smtp-Source: APiQypKs8y6Vg2KzmMT4g4oZu5wiFa4G/kju8yqlU96SeL7qZ7ELe7MmcVgtpvP5CqJLwjK9A2qIovwpySFpCdeuE3I=
X-Received: by 2002:a5d:9494:: with SMTP id v20mr5060146ioj.101.1586100632475;
 Sun, 05 Apr 2020 08:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200405104913.22806-1-peron.clem@gmail.com>
In-Reply-To: <20200405104913.22806-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 5 Apr 2020 17:30:21 +0200
Message-ID: <CAJiuCcdEMDJik7jZYkTETF3D_H6Y0OLND46e9wJ2vsTtnrb0rQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add support for Allwinner H6 DVFS
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 5 Apr 2020 at 12:49, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Hi Sunxi maintainers and members,
>
> Now that required drivers are merged we can contibute on DVFS support for
> Allwinner H6.
>
> This serie is based on Yangtao Li serie[0] and Megous works[1].
>
> Most of the OPP tables are taken from original vendor kernel[2].
> Plus there is a new CPU frequency @1.8GHz.
>
> I wrote a simple script to randomly set a frequency during a random time[=
3].
> With this script and using stress-ng during a day I didn't see any issue.
> Moreover I have tested specifically the 1.8GHz on my Beelink GS1, max the=
rmal
> 80=C2=B0C is reached after ~10min and then the SoC oscillates quickly bet=
ween 1.5
> and 1.8GHz.
This result is wrong ignore it.

I will resend new one in next serie.

Regards,
Clement
>
> I also test that that offlining CPU0 and doing DVFS on other CPUs works.
> As CPU regulator is only set for CPU0.
>
> But maybe it doesn't cost much to set the regulator for all the CPUs?
>
> Jernej test the GPU devfreq on several H6 board particulary the Tanix TX6=
 which
> doesn't have a proper dedicated PMIC and doesn't had any trouble with it.
>
> Do you think I can enable GPU OPP for all H6 Boards?
>
> Also Yangtao Li enable DVFS for OrangePi and Pine64, as I can't test them=
 I
> didn't reenable these boards. Please, let me know if you want me to add t=
hese
> boards in this serie.
>
> Thanks,
> Cl=C3=A9ment
>
> 0: https://patchwork.kernel.org/cover/10815117/
> 1: https://megous.com/git/linux/log/?h=3Dths-5.7
> 2: https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/ar=
ch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi#L345-L517
> 3: https://gist.github.com/clementperon/55a055dae3f13bbd14fb39c0069fe2e2
>
> Cl=C3=A9ment P=C3=A9ron (4):
>   arm64: dts: allwinner: h6: set thermal polling time
>   arm64: dts: allwinner: h6: Add GPU Operating Performance Points table
>   arm64: configs: Enable sun50i cpufreq nvmem
>   arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Beelink
>     GS1
>
> Ondrej Jirman (2):
>   arm64: dts: allwinner: h6: Add thermal trip points/cooling map
>   arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
>
> Yangtao Li (1):
>   arm64: dts: allwinner: h6: Add clock to CPU cores
>
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  10 +-
>  .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 103 ++++++++++++++++++
>  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi |  74 +++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  44 +++++++-
>  arch/arm64/configs/defconfig                  |   1 +
>  5 files changed, 226 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
>
> --
> 2.20.1
>
