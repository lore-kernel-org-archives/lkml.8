Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC35C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0100520728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zlu6VfX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgD0I3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0I3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:29:43 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62243C061A0F;
        Mon, 27 Apr 2020 01:29:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so12809414edv.2;
        Mon, 27 Apr 2020 01:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3u0dV855unI4O3p8peLsDTUicXAYlb28KnCe8UM7MUs=;
        b=Zlu6VfX2l+7goUVTDjG0v+TCcX75zOZGXqTIdVxBqOlF54VJrT09yWSCdeAt86pL5e
         IR3ssFL9phUIY4cr04VSZ8exPUkcdWgSSislA+X+jcvoelNI6YDI8O1ynEGTXy/+IQdl
         UPD7Nxcf6CE4y3EFj1kwkIMoz8P6STCkLLXBL1NDVVgq6pEkeCJavGgsTDm5zz8XPufO
         Xthx3bO2cYdQ7/GMIVxOyZ3zFuN09avlPFWfLgklAq/pa+vAdO84iaowsDdqhgFsw5eR
         vB8tdAjJvjxu1VLa2ioiMjRM7dS5j/VYyUqdPE/ZPXr3XaSfXaUk3r82WSJY9C+8qGId
         KrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3u0dV855unI4O3p8peLsDTUicXAYlb28KnCe8UM7MUs=;
        b=EMdeo9w+a+aETHo082VgEWrzB7VWEY0wQ4GAY8cB/zl4Nj3lokGaK5QW9V+5SyGi5l
         t0pN2WSR+nQXkWtlI1KmGc3ltdgbNFMTvVxnoI4MVZKxNgFwR34Q9lojXgm/Qj5gwNMR
         97864uXLMPO18amCvp6LF4oFuvuDzRDiShZ+3YjAyH/eMJKhPCTno+f7gBt6lAfp2I3l
         GZ0G8Zw8qf2f13UOMPPtlD24lrQO0T6ySsnv+77IEynZwjugQ6+fRw/MAuUqZeEMehBl
         3M9BFDFMQUw5MBlBo7VuB5sla1MHrI0/SwgnMnAhkZXfyp47VjnsXPA1eprsjqTe39QX
         qf+g==
X-Gm-Message-State: AGi0PuaGLDdGoenl3vI0V1ewPWWuboKWWzBebQY0upztLojrzQZtC6//
        4FFX0kb4eKvCvkWkDeP6rdlNmhYx/qQ=
X-Google-Smtp-Source: APiQypKbYjp0Ad9RAw21UP4Z6Nd2JIoYOrwLCpAUf/+Tg0yEq9TchOmQsbsVdRSuZVn7vzuOqKCM7w==
X-Received: by 2002:a05:6402:391:: with SMTP id o17mr17630403edv.71.1587976182020;
        Mon, 27 Apr 2020 01:29:42 -0700 (PDT)
Received: from localhost (ipv6-80adf4751ff4da96.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:80ad:f475:1ff4:da96])
        by smtp.gmail.com with ESMTPSA id r26sm1976873edw.34.2020.04.27.01.29.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:29:40 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:29:39 +0200
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: enabled inversion
Message-ID: <20200427082939.GB18436@portage>
References: <1586424250-25897-1-git-send-email-oliver.graute@gmail.com>
 <20200409101517.GO2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409101517.GO2001@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/20, Dan Carpenter wrote:
> On Thu, Apr 09, 2020 at 11:24:05AM +0200, Oliver Graute wrote:
> > From: Oliver Graute <oliver.graute@kococonnector.com>
> > 
> > Enable inversion mode
> 
> What the heck is an inversion mode and why would you want it?


Should I name it:

Enable MIPI_DCS_ENTER_INVERT_MODE

Best Regards,

Oliver
