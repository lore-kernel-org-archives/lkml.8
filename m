Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F65C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFF020672
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JODeAhJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgGBN1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgGBN1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:27:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265A7C08C5C1;
        Thu,  2 Jul 2020 06:27:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so27516829lji.12;
        Thu, 02 Jul 2020 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmMp6GWfdvU4LKFzCvwGdPzogv0V4WL8Jcd/f2Bl1XE=;
        b=JODeAhJotY8R+UsP5Kpm0aGc23vl+GHdggSxh+ajg/g10ya+jXh9qoI+u8Cz/iS7sE
         f3mOLbDafq9NhGJbOg3SZQYq2ItyVM/LykVtLqCUddZuW2f3cncEHJiKGrsIoEvOwE5i
         BHzo99l2CHQRxDU9m3ZTjaUB7fqERtXr1KMPwpIKHNf1PbqQnCy1kXXJJPfk6nU33M+3
         cv0mc46Yx0uLmzx8Vtx41wQWoetW7t0xGuFwhFc7vmvJBUo2ZwX4ZBgJGBCeIGwA/gWX
         PSWBvPGxCgmkJ8TF7m3hby9b/wTQRTd/8t/CAGq6xHmDxMWGVCEbZm0YI1Os0mBeVtsQ
         Ubow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmMp6GWfdvU4LKFzCvwGdPzogv0V4WL8Jcd/f2Bl1XE=;
        b=OP1hxDDHRZB96k/nCTxLl8aa9iGOMknPAArsBXkkOECudotSXX1KWdnwPYlC8kubma
         mJfSZkiyQobgFG8R+3VnI0p9TYh8h5PHmHc4LqdiyNNjUE7BTjTRXcVjW45WhegwQjvs
         Xd0jSJ2HKdI3B7PTOn769Db7NeidDrg01HBXzmBMlOPKuuBsTazPOC2XrwZ1UFUvQhf7
         w/BmaoOEp+HbpV++0ZUFmNtlMrij6kEXCxJEBrxzpCrsdEdDdxhizgDxEs3l51KFOmze
         jbdb+N5vpKeo84ilbOLk2SRbiOMM/W5rBTyNL0ZbpM3nVWHVoA8d2UX2Gp7Jdr9eprxI
         T1oA==
X-Gm-Message-State: AOAM533LwbXd4vzg8YBA5X7epJ0kaBOo2gGmJGq7KxAjc31m3cFYRWXq
        Jkt4OZplrgY+xRlB4C9XF/EtheLxnpcZXiuCNsvyEg==
X-Google-Smtp-Source: ABdhPJwhdkFLp2bUaT1fQ2Ocaiy4B3289ixJwbV9gddATi1cvxPwA2V959z6kkL+0Atjhixfhu0k/Mg3AUuQ7uHs8hM=
X-Received: by 2002:a2e:8199:: with SMTP id e25mr1450607ljg.307.1593696460661;
 Thu, 02 Jul 2020 06:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <1593694973-34113-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1593694973-34113-1-git-send-email-clabbe@baylibre.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Thu, 2 Jul 2020 23:27:29 +1000
Message-ID: <CAGRGNgWqSM9HKtykqUn1wC5N5mW+RRTbfE89pBP=e2t_geDUmg@mail.gmail.com>
Subject: Re: [PATCH] sparc: sparc64_defconfig: add necessary configs for qemu
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

On Thu, Jul 2, 2020 at 11:03 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> The sparc64 qemu machines uses pcnet32 network hardware by default, so for
> simple boot testing using qemu, having PCNET32 is useful.
> Same for its storage which is a PATA_CMD64.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/sparc/configs/sparc64_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
> index bde4d21a8ac8..61073f48a7a1 100644
> --- a/arch/sparc/configs/sparc64_defconfig
> +++ b/arch/sparc/configs/sparc64_defconfig
> @@ -236,3 +236,6 @@ CONFIG_CRYPTO_TWOFISH=m
>  CONFIG_CRC16=m
>  CONFIG_LIBCRC32C=m
>  CONFIG_VCC=m
> +CONFIG_ATA=y
> +CONFIG_PATA_CMD64X=y
> +CONFIG_PCNET32=y

FWIW the CMD640 is the IDE controller used on the Ultra 5/10 machines.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
