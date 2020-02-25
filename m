Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5561EC4BA01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC6C20838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ML4KwGNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgBYWwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:52:40 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46187 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgBYWwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:52:39 -0500
Received: by mail-vk1-f195.google.com with SMTP id u6so229896vkn.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7MQONwXqnHZRXQDO+5cFHOizIPUenx2kjrngECUQSQ=;
        b=ML4KwGNSQIrO0D7ruk1fYSg4pB4VLASqOhJQ3+uvt30zctxClfPEpcN/raNLCNmle0
         SzlFwyCZJpsknAC2v7Mx6mWCveGnkD2zRjQq6VBxAdF6c4ozhJ2E419eCZdmA/VTqlB5
         gtjdkt9Xhdv+Hl8JBcTplN/eAA3umRtDZL0Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7MQONwXqnHZRXQDO+5cFHOizIPUenx2kjrngECUQSQ=;
        b=ATe2DudB5PQW6qKDQDNb9vg+eXCA061TMO47Tbw0d+yLaAsst+2B8VaJaGEBqXUjxi
         1bOTQ2LyKJoHeIjO8tY7aw6dQS5AVG+98ogM/Nnodvxts3qmYzY3s2J0zONwH7ugtJmg
         4k43lTNl/icIWQ9iLlESQMIlPinGmG4e3rXWcFmioe0lSyk0f1Pd2Nlzt+je7ljRXccE
         A/TXZvVLCHsnd9/I/t0nBXdY0/Qpx0qUeL783+U8cUarUTJOuVDLcRfX2E8LwwKiqjQ1
         q2brhH2C3RjdVAESNjogzmsehqtUmJ095Ozb/HazXTZFf6WapdK8hpsHgvK7bEpuWB4A
         hT/g==
X-Gm-Message-State: APjAAAVZH5rzMSA3so9DDiM8akvX4hij0bzU2YGn7lTGqUVmSPAneFnJ
        PPqT62ot5ee5mGU+bif2v1OvgFBDs1g=
X-Google-Smtp-Source: APXvYqyr+vn9RfOcYhk5/I0/1qgj3NcN5PdMOZMUXXc92/JpgCFe0oDmIQAC194f7qjn0ImWrSg5Qw==
X-Received: by 2002:a1f:c686:: with SMTP id w128mr1261768vkf.34.1582671157806;
        Tue, 25 Feb 2020 14:52:37 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id b20sm48511vsq.20.2020.02.25.14.52.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 14:52:36 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id n27so598595vsa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:52:36 -0800 (PST)
X-Received: by 2002:a67:e342:: with SMTP id s2mr1474052vsm.198.1582671156402;
 Tue, 25 Feb 2020 14:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20200103045016.12459-1-wgong@codeaurora.org> <20200105.144704.221506192255563950.davem@davemloft.net>
In-Reply-To: <20200105.144704.221506192255563950.davem@davemloft.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Feb 2020 14:52:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WiceRwLUS1sdL_W=ELKYZ9zKE13e8vx9SO0+tRvX74QQ@mail.gmail.com>
Message-ID: <CAD=FV=WiceRwLUS1sdL_W=ELKYZ9zKE13e8vx9SO0+tRvX74QQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: qrtr: fix len of skb_put_padto in qrtr_node_enqueue
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Wen Gong <wgong@codeaurora.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ath11k@lists.infradead.org,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Sun, Jan 5, 2020 at 2:47 PM David Miller <davem@davemloft.net> wrote:
>
> From: Wen Gong <wgong@codeaurora.org>
> Date: Fri,  3 Jan 2020 12:50:16 +0800
>
> > The len used for skb_put_padto is wrong, it need to add len of hdr.
>
> Thanks, applied.

I noticed this patch is in mainline now as:

ce57785bf91b net: qrtr: fix len of skb_put_padto in qrtr_node_enqueue

Though I'm not an expert on the code, it feels like a stable candidate
unless someone objects.

-Doug
