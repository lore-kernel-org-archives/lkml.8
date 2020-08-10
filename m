Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC82C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065362073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9sOniDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHJINd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:13:32 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D0AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:13:32 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id y18so6804619ilp.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JVxd0LfquvEwFWlVzm0eoYFyTaACuRCRqytuLnTbGs=;
        b=a9sOniDgn+OX3mKLx8wyRn8G/5nz6p0EI+n+UIFh/JhVHrGaGWBfyBK8qTpZW46Zms
         hdRV6io4qZc/g8y8ufYqkof85s+/NTHPQKA02wTMCODPBydcjrwfgTE/IQWKIP+lzmSv
         wxHMVmyC+DZgK/X7uZx3FZSFhYr6wD7qgFNMt+R3KNmdSIRH7CU3OLWUrTVEpOW8Qme6
         myEN8Tpphf6T40JIWhx5Jm7DMOwy8WNGedfxBcBWj9iuiTzAD+M2nwzQN30h4V+LIOyv
         d4viMILdQO9wDAxaDrPZ9AcpRy9j3NTDK6hoVLQaNrijwaUe7Ex1jdY/o8+7qa8OzqVM
         eQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JVxd0LfquvEwFWlVzm0eoYFyTaACuRCRqytuLnTbGs=;
        b=BZZowgeEYDkkLYzcdf9BwJHNNkD/+LewxPKp0k/pRenf5TTl6402OHWE0QgIXkFR39
         ZdKan6dQtGqYFTGVSfDlohvruine7kA4/6c8dfijY4MBV/zo/IZXE/eOwfr0zc5wcDog
         4TeAocyU4WxdG0r2eF+dpekvlPWPbZ1+JNFWf5UQPM1jwhGCTcNTSNCiF1AxRHSa/Dh/
         l3rM/52sCuRBkjXeOhxAJ2TdGO/KK5w5+hMeJaifV9FWWCpZ+vASvEZIzXMyskz+ZjoB
         bjxCF1rzcpihN1BU7vZkvFr6CmdgfNgfQ5UKv9R52XoLBUzLoyqaYSdVbxL0SyQvWRrj
         jEGw==
X-Gm-Message-State: AOAM532ITuHMnmQPwgdwrG7O5MhL/TaJ0P7vBuh0qstWZruYQnhBvryN
        MAIoKVArWliSrdBKI5OYWyRECmqSBBuLKdqCnGmszQ==
X-Google-Smtp-Source: ABdhPJysEFivEl0vYFplJC98GA9zeoDMNIxEa41sPvOq3HRZb2utcdXYgn2Zdo1CLZ1S13FPxCHpNSCIioXFwjPxw9I=
X-Received: by 2002:a05:6e02:1387:: with SMTP id d7mr16832113ilo.140.1597047211233;
 Mon, 10 Aug 2020 01:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <1597028754-7732-1-git-send-email-jiaxin.yu@mediatek.com> <1597028754-7732-2-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1597028754-7732-2-git-send-email-jiaxin.yu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 10 Aug 2020 16:13:20 +0800
Message-ID: <CA+Px+wUkL7XwkppMA745cP_foNweaBLOSs0=BVzcDr0PEC+_Ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: mt6359: add codec driver
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, howie.huang@mediatek.com,
        eason.yen@mediatek.com, shane.chien@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:11 AM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
>
> Add the mt6359 codec driver.
>
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

This patch also reviewed few rounds on https://crrev.com/c/2299951
