Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE06C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0096D2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SWWR+Upk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgEFWk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgEFWkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:40:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636A2C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 15:40:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s10so1238132plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QdygR2A72/9LbEfVx2KFs3XOLDP2FAPzE7Df5641CTE=;
        b=SWWR+UpkmvIE+5IkhyyAYX+75Y/7/mDnDtfjR2ghLwrvagpWXgIcXAMbXN0ctOmC7J
         r0FxwlPF0uoG20mDKj/ixX1NIadS14OGfhEQm5Yy4h1fp3BkOTWg3wrCj17q6zI+ekN/
         mDFNQPcrBFBtYUtdiJxBZH03mttId5kD4H4tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QdygR2A72/9LbEfVx2KFs3XOLDP2FAPzE7Df5641CTE=;
        b=YC4/aLy+tUTPfmlfu7pdMQBJHT5x0vFjmEw5lNoHDXBWVg/LlXhrxUm2aKITYLHolU
         LGh+ZgCId+gFMvQrFnDHhPSXfVo+WPnkI0DOJ6wBKcltN7hYs0oX84NyHEaXGnKy4QGt
         daXxFigObYE8uDl+yVZwtKXIGYcpJgKrZzjfZP+UWf6UaUcAga/rnZFcualn//Mdgrtt
         u0zFiCW/Hac3WEghoslqO+prVwWS9vNHYnZVf97/+D6WuLHzSBgqkELIf96QK52LQ5bc
         t9lrmm+m5rThersJcWVqOFvhS8HFnv8QQlziGJikiFaHuOU95Vvj8sJrub2rOTPABF+m
         wlKw==
X-Gm-Message-State: AGi0Pubmc7aGWK/zmvGkx+IbuHWrsVs20TOytSlLsfEQUEjoawPIGUVw
        u0F26pHipwDlW5ne8vylm3GLCg==
X-Google-Smtp-Source: APiQypLeKev/qpKuUfyxub8k75/PIRWV5N1ol74IL1rE5d96sthNE61DOXvqGS/dnem4REr+Biuuuw==
X-Received: by 2002:a17:90a:280c:: with SMTP id e12mr11866676pjd.52.1588804824838;
        Wed, 06 May 2020 15:40:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b140sm2819009pfb.119.2020.05.06.15.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 15:40:23 -0700 (PDT)
Date:   Wed, 6 May 2020 15:40:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, jmorris@namei.org,
        sashal@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] pstore/platform: Pass max_reason to kmesg dump
Message-ID: <202005061540.88ECA85@keescook>
References: <20200506211523.15077-1-keescook@chromium.org>
 <20200506211523.15077-3-keescook@chromium.org>
 <4cdeaa2af2fe0d6cc2ca8ce3a37608340799df8a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cdeaa2af2fe0d6cc2ca8ce3a37608340799df8a.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 02:25:41PM -0700, Joe Perches wrote:
> On Wed, 2020-05-06 at 14:15 -0700, Kees Cook wrote:
> > From: Pavel Tatashin <pasha.tatashin@soleen.com>
> > 
> > Add a new member to struct pstore_info for passing information about
> > kmesg dump maximum reason. This allows a finer control of what kmesg
> > dumps are sent to pstore storage backends.
> 
> trivia:
> 
> > diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> []
> > @@ -96,6 +96,12 @@ struct pstore_record {
> >   *
> >   * @read_mutex:	serializes @open, @read, @close, and @erase callbacks
> >   * @flags:	bitfield of frontends the backend can accept writes for
> > + * @max_reason:	Used when PSTORE_FLAGS_DMESG is set. Contains the
> > + *		kmsg_dump_reason enum value. KMSG_DUMP_UNDEF means
> > + *		"use existing kmsg_dump() filtering, based on the
> > + *		printk.always_kmsg_dump boot param" (which is either
> > + *		KMSG_DUMP_OOPS when false, or KMSG_DUMP_MAX when
> > + *		tree); see printk.always_kmsg_dump for more details.
> 
> s/tree/true/

Eek, thanks. I'll fix my typo. :)

-- 
Kees Cook
