Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE82C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B302075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8FA52NA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgH1S4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgH1S4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:56:04 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65DEC061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:56:03 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 189so174967ybw.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnNw5CWzP8lUiH2nZYQGN5jpBc++mmmv4sVoEABnC4g=;
        b=f8FA52NAkvfzgqADf0WbDOllQdDHETwhwuBzyyZlBAxXm1kSdwykbXKcXETq/UZQh1
         yl6Qz91C9trg3GmpuSvN/maT+lIQpo+dpWsNeTdjJK4D/Ejk+z5fZxbFl/MuSmoXFvC8
         DjjNnDcQfBrXsmSe+NoV+uplsoNYOJFvHzTkeUawf0qQRzQeBtwQSXhGUMecAjtN3uXf
         hNHbUBKd9etS6goe/ZRIfOm4IW9y4/cn/+ZDP5598zY0rJrRXweXrk7+/2cswpx+8jwm
         WEZzjH6EX8taGoOQ9GmEbdaGKknSHjC0sjvm73zPx/B1nERvh2JV8/svQeRu4EzZsgCD
         KkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnNw5CWzP8lUiH2nZYQGN5jpBc++mmmv4sVoEABnC4g=;
        b=BFU+mkVcZqjOP9xLdpuEtLHJKkI0MOUWoICVZRAEchYxcov2QGt3DBRAdqOY6qfHxg
         GZ6+dF9loPwXLtTV3DaenDYWPjZDOSVXvV0VWWF6VcNbzyV6SP7ksdj5QA+OH3FRz+cW
         sDDK/pMS9XbhSzJ1N7dSznduFHK6g/Q85kZuLPqtU3olLni+Pv1Qr66CYNVDCg/GM2XG
         rtODJdGybzIG6SCgsHNG9wz/bJrdF6rLvwSk3kwMFIj4lLC1jDGJDZPno2L+VSyUpJJc
         V+6T3+AeFHrBLs8vIfZ2vS3er3ThacLaIyKyqlWAITs0N9lSPeew2yMsxFE61IFplseF
         gemA==
X-Gm-Message-State: AOAM530cXzVQpx+hZiEDqnPvfSATtuu4PV6EnGye17wxl9Cqwz+bHoZ/
        eVjo+RxFQvFFqivTLdJZqsfFNRJ9IEh9kfUz6svqNg==
X-Google-Smtp-Source: ABdhPJxPjCSCMQ7LhbKWQ7XUp5huhPtc67UGElcc3VCbR43Fg78gP/RFIm6MqpkF90shYA+0NmVp2l5Q4+Tt5ZQQU/0=
X-Received: by 2002:a25:ad4e:: with SMTP id l14mr4478460ybe.322.1598640960119;
 Fri, 28 Aug 2020 11:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200823012134.3813457-1-agoode@google.com> <20200823012134.3813457-2-agoode@google.com>
 <20200823145417.GC6002@pendragon.ideasonboard.com> <20200823150822.GD6002@pendragon.ideasonboard.com>
 <5a2882e5-c029-dde7-c6ff-bd6f57aa7850@xs4all.nl> <CAOf41NnrfW6h++nR42R1OxR0B3DVrKg9RVLTQVJ=nEkn3GW4aw@mail.gmail.com>
 <6538b14c-e386-2fab-d178-7bb3e98b3525@xs4all.nl> <CAOf41NmOdb1Y3ZSO7YLxyStbSfUCo8p204TdvkwH91cXdmNq5A@mail.gmail.com>
In-Reply-To: <CAOf41NmOdb1Y3ZSO7YLxyStbSfUCo8p204TdvkwH91cXdmNq5A@mail.gmail.com>
From:   Adam Goode <agoode@google.com>
Date:   Fri, 28 Aug 2020 14:55:24 -0400
Message-ID: <CAOf41Nk4Fn=-mtZLr_TRp2PRNS+cAc1o9=Y8zw2newCmcHobQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: uvcvideo: Convey full ycbcr colorspace
 information to v4l2
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I sent a v2 patch last night, thanks for all the comments here!


Adam
