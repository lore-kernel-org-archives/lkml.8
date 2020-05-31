Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC2BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D272068D
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="MTo6rL+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgEaTzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 15:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgEaTzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 15:55:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBF7C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 12:55:43 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e16so6220121qtg.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p16Dz6KwMTsKYcEwRz28WdITu61eUhpMtwje0OvV48U=;
        b=MTo6rL+DjSq4xwf5QfiHiyhNkSz+60L+w2e8681uN5dTNBa6p3dVzP/auVs29Vaki9
         QgzU3iGkdMALrkbzXBvWM1+t7gjle2jUaIclhn2KOrv1RuMmZdTfUcH14RhwjJFfEt0E
         IzE0X4j5OrkNC8smn/4cnS9hiTuq/cDQqFE5I1H/yef1hYzqAv4pzxlWrfZ75b4VX0Yk
         nhfWz13hd7IDAscN3p+TJ1p+DHSUZulJierPTmMY5UwnSyynZ/2xtyntwSQbisqIkJ04
         ziQq66zoJ8uIHahqR17lmtLpYf7+sWbGaJJJNYMhId+aHkO8J4DEO/jZo38tCtlBh125
         6QJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p16Dz6KwMTsKYcEwRz28WdITu61eUhpMtwje0OvV48U=;
        b=OeX+JTfRf3rcKyRmCr6mwUKUL/KLbHn75V3FiTpvRWvN9BqSMQkuCfYMrE++okK1k7
         hUJE3leDmb2aP6nKnqGhux+pn5oDZBWfNdBOdg28f3TtXk9AZ9o2pOIuimd+WpOgX150
         hKRGxlmS4xFNgVb8p5Sdep1TnLQ9ncPov1ZN9YG5+8GlwyLZPG3PWcJu1C4GH7tSpO7r
         Gfn0IoVraa+4zxylKt6jcujDg7jv/yJTg5ISSgoG5Esm7eqtB8qzRjH/PmgaSfapNuh9
         kVsaVys+IUqcwz/91QmMn5E+4v2JK0Hv19Dy4EfTrr31MAL3NYyi9J2f7CG12ZHqZyZy
         eUYg==
X-Gm-Message-State: AOAM5302UD4dAEi5TKy2C+iz2AExMwI15OoFguYMABtb3fmRaAAzt9sr
        rx6twAYBpD8ML/TTXCIcp6VrgA==
X-Google-Smtp-Source: ABdhPJw0XEYJHwGb6Mj3+r3rdTz7i09/SErnjjcGy8IwCOskxslnN3zFZwz9z2P2RA1ij3/aT3maBQ==
X-Received: by 2002:ac8:2f7a:: with SMTP id k55mr18787986qta.34.1590954941399;
        Sun, 31 May 2020 12:55:41 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a664:2e00:a5da:931a:7f23:1d4d])
        by smtp.gmail.com with ESMTPSA id s4sm12308438qkh.120.2020.05.31.12.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 12:55:41 -0700 (PDT)
Date:   Sun, 31 May 2020 15:55:39 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Wesley Sheng <wesley.sheng@amd.com>
Cc:     dave.jiang@intel.com, allenbh@gmail.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        wesleyshenggit@sina.com
Subject: Re: [PATCH] NTB: correct ntb_peer_spad_addr and ntb_peer_spad_read
 comment typos
Message-ID: <20200531195539.GD4620@kudzu.us>
References: <20200526075943.20756-1-wesley.sheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526075943.20756-1-wesley.sheng@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 03:59:43PM +0800, Wesley Sheng wrote:
> The comment for ntb_peer_spad_addr and ntb_peer_spad_read
> incorrectly referred to peer doorbell register and local
> scratchpad register.
> 
> Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>

Pulled into the ntb branch

Thanks,
Jon

> ---
>  include/linux/ntb.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 8c13538aeffe..b9b0d805d0f9 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -1351,7 +1351,7 @@ static inline int ntb_spad_write(struct ntb_dev *ntb, int sidx, u32 val)
>   * @sidx:	Scratchpad index.
>   * @spad_addr:	OUT - The address of the peer scratchpad register.
>   *
> - * Return the address of the peer doorbell register.  This may be used, for
> + * Return the address of the peer scratchpad register.  This may be used, for
>   * example, by drivers that offload memory copy operations to a dma engine.
>   *
>   * Return: Zero on success, otherwise an error number.
> @@ -1373,7 +1373,7 @@ static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int pidx, int sidx,
>   *
>   * Read the peer scratchpad register, and return the value.
>   *
> - * Return: The value of the local scratchpad register.
> + * Return: The value of the peer scratchpad register.
>   */
>  static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int pidx, int sidx)
>  {
> -- 
> 2.16.2
> 
