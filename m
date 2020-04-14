Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B82C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 05:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0AE20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 05:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVaijEY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405592AbgDNFrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 01:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgDNFrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 01:47:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9AC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 22:47:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b8so5588784pfp.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yyr/qNo1z/Ovmw6kxXGXBktCqMugeZRWv59qM91CiOA=;
        b=nVaijEY0Khf25YWcU/vvAqY+XMzsnljbCI2I5j+aiVBKczR5LkF+8sxkm5SBbhX5aZ
         1q1pW1GYqvPU+ugpAKOGIEHUV/cgEwX+80sTA1fwTCGCEyv66OzBz3F/JBX0gOMOJWTT
         FnlpcotnSepB1aEBICtOkIrsigsJLvszgOQqDyGniKZmwwZtJusMwrBu23RwS/isnnLK
         pbcNiHcNfdaK/XnOKaP5h3ZUHn3/bUMIVK/7Bn/3RF690icAG4cTOJjP85n+7I4OIq8A
         GPYYQVyaKlFPTZbDvBRr6v4M339iChqh+eiwLtj938gxGjT0VuAXhXXFa9SvwpLKdqV4
         FZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yyr/qNo1z/Ovmw6kxXGXBktCqMugeZRWv59qM91CiOA=;
        b=bdgqmUoSjn7OaxioVud2OCs+IDXL+lfFRvql5ydSb/mcXczgKI54F4PcZicsWBuneS
         v3SqukqQK8g8Sx0gMTKTOTSX2IuwhIbEzcixChc9OmlbGp24lteSFMp3tvLmg+MAnhgg
         302Az2WMCslLpzYxBmdFppLWErFzD8Zv4bKwTvZbeBNtr7Iz3P7LP2q+/eGKIO0XN/M0
         dGe/h/H7E3ErkxvuB1nikPpCtGHRZa2SOPrjdUrOX5/11d4BYiq7Uxzl+SLD7yWFzF2b
         +l4Q9fmJHDxMUVn4tQ7gyTB7iIBpoUXQT+Nslz8eoPxdzDsaPUJicWnbwdl+s2J708lR
         z0Jw==
X-Gm-Message-State: AGi0Pua7nIBSHgoREGfK72RjDlqf76nwhjAoiXffDEqakIrWv9kAK7PQ
        WhV/kKEgPwjbc0p4efjalPA=
X-Google-Smtp-Source: APiQypLSYJjkrg4P1ufAWzWXxjrGx0c9u8O3UJURRbxrfyFBnU3L77kCuBC1CAjqweSaN+YtPhDPUw==
X-Received: by 2002:aa7:963b:: with SMTP id r27mr21049125pfg.71.1586843233693;
        Mon, 13 Apr 2020 22:47:13 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id c3sm10082612pfa.160.2020.04.13.22.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 22:47:12 -0700 (PDT)
Date:   Tue, 14 Apr 2020 14:47:11 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH TRIVIAL] printk: fix a typo
Message-ID: <20200414054711.GB12779@google.com>
References: <15022308-a15d-7843-4d5b-d72a58efe99c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15022308-a15d-7843-4d5b-d72a58efe99c@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/13 09:14), Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix typo/spello.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jiri Kosina <trivial@kernel.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
