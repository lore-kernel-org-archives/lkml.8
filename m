Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6455FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36ECC2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bNJ3J262"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgFZVwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFZVwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:52:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A04C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:52:44 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x62so8634631qtd.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unTEhFHTPIbe69CpCLwt1ix5Kgyr/d1f6HtKXpl1zVQ=;
        b=bNJ3J2626dcj69quM6yIyJ6MDt61F5nRnomPfXI/9wvRiEcIh5VGqtrUwOfPHmh39Q
         wm59l3bU1u+8zjjCjnZ+tyhqA/gzflvF0Hp73htdfyq7i02qplu2MRwWENZJ9i5r1AQy
         ttj9Pe+eDkjFUa+AxZ4WwkVaN/bHsJo6fFmx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unTEhFHTPIbe69CpCLwt1ix5Kgyr/d1f6HtKXpl1zVQ=;
        b=CwRVVD+jrlTOZixIsoWJux9tW+RlZFDl+ylmbsXRUbt5Dd+TCCJrbdqcMv5pG3pGqJ
         yUi3D98nZ9+yD4DbBVj7uielLBPUXuRKsdx+tM7g+VvPzfjUdKZ1HdLTT/FZ02/Gqxed
         Fwky4EKo6TNPuGFJ/IBHZ9rKSCmmb3pcqlWnynR0hjiLXnmyvXcGB+mnnCFcM8wFq3GU
         uu3TgUoKPImYTDkR6DZK0wwHT/eK5yAaLewnzrhZXUVmGZJbF/tNr5ne1hw93zhlgnFq
         4GaTDfoUU0UsDsJ1OotIoow2eiZT6Xz4rEL8gmMXXLowVunamsjDz0qLc/v3PCkve/9Q
         ERwg==
X-Gm-Message-State: AOAM5310zol+1M/zKPyUGGIXqcsvioglXogH12ggtlMbu26RjSa/vz9g
        myGSt53s3Xny2a7z4S3FCpM6WOKqmDc=
X-Google-Smtp-Source: ABdhPJzm2a05RamXN0bugHImbObHv4RG5DrOtHctxrHQxgSZrgdPUeH/oKwBm7RIT7SaDI9eBLaMxQ==
X-Received: by 2002:ac8:408c:: with SMTP id p12mr4862739qtl.332.1593208363258;
        Fri, 26 Jun 2020 14:52:43 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id i10sm11564152qkn.126.2020.06.26.14.52.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 14:52:42 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id d12so5190761qvn.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:52:42 -0700 (PDT)
X-Received: by 2002:a0c:c607:: with SMTP id v7mr5210062qvi.84.1593208361576;
 Fri, 26 Jun 2020 14:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
 <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com> <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
In-Reply-To: <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 26 Jun 2020 14:52:30 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
Message-ID: <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 2:49 PM Doug Anderson <dianders@chromium.org> wrote:
> I should also note that, while I'm not terribly familiar with Kalle's
> workflow, I would have expected to see him in the "To:" list.  I've
> added him, but it's possible he'll need you to repost the patch with
> him in the "To:" list.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#who_to_address
https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches

Patchwork is his patch queue, so I don't think you need to address him directly.

Brian
