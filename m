Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D46C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2B920724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCaYXyky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgCMMj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:39:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40649 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:39:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so4934871pgj.7;
        Fri, 13 Mar 2020 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=82fh5ikZzwKUrDyxKdkrVpEoXp45d69vwfzZrK4OB9Y=;
        b=pCaYXykyMMfYJbyQ038KVkMaZj5sVhcE1wI9n+DIITZBD1COymiWYDlC2+vi3BkDe5
         i7kQH6pmbvgu8eANJjGjeZlLUrWXum7PjEX4DjLSqgLEctKva8qM21NXiDYAf/DDQQQE
         L8rxZMTefdgs00WF8xnVu/Y2y8Mwji2lTJixln5E6Q0Vu8eaUMKHQUSworyvlNbGMb4w
         IHqkVBWBsEsO6tOsMRMy+L9MW6A5kxdx//5JLo7nnCLfITirV2XeXYXFuyW/ULCzklY1
         3TmT73s3kFSu496C7jyF5KB3W39w/czyDIczygu6zBAEbcnfy6NyYVEfe8Q2rCDwcn7K
         XoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=82fh5ikZzwKUrDyxKdkrVpEoXp45d69vwfzZrK4OB9Y=;
        b=lrrAXZ/ySUvrtMzKrk//L5Kt30ErUfhJjKOnPz2rypAQmYXQcp35oN6vb0ZvBTpEXi
         uU4iblh2d89b2cCIm8IHxKFEk76G76ii6E7tWXD0jwhC9OqjiVk++fhTgM5tETx6eGni
         R/JNvHiixn3SttHRK3JKn73dnGO7DMY4FLxIQJTQzeJd+aMVMcuYoK8AVyNT76vmnFNn
         eQyPhLA2lUDXQp19vQgY1FebMsDcGDKjQ1tlCzBQZDo57xuEnLS2Y3HArSUmcQW4kCRR
         B4y9leaOulBKnKGcsGW0d6F1i17qvtu+b8EkTs8LFoWA0L3yk4tt+ZFYmw9JcCzdbi8j
         1/0Q==
X-Gm-Message-State: ANhLgQ1CWs0+y+J2J/aRdq+/j/q2VulJHbTz4wfmSsppfzZrBRhpLGDH
        E4GkIgfzfPkWIIkThVuxLTwPX+AZ
X-Google-Smtp-Source: ADFU+vuImrtM0XybOBDGHeqm5s5eZa/2ofaKmPkRzVsqKSc+epZy8Mo8eq/uT1r3tLISxjO+lRdp6w==
X-Received: by 2002:aa7:81d6:: with SMTP id c22mr5822084pfn.147.1584103166804;
        Fri, 13 Mar 2020 05:39:26 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id t17sm57522622pgn.94.2020.03.13.05.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 05:39:26 -0700 (PDT)
Date:   Fri, 13 Mar 2020 18:09:24 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] parisc: Replace setup_irq() by request_irq()
Message-ID: <20200313123924.GA7225@afzalpc>
References: <20200304005025.5179-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304005025.5179-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge Deller,

On Wed, Mar 04, 2020 at 06:20:24AM +0530, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
> Hi parisc maintainers,
> 
> if okay w/ this change, please consider taking it thr' your tree, else please
> let me know.

Seems you handle the pull requests for parisc, if this patch is okay,
can you please consider for inclusion in your tree.

Regards
afzal
