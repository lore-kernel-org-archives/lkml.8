Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829ADC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAF520656
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgbV3zLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCBNyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:54:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33708 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCBNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:54:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id x7so12734942wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SSA2y7JF1KwXaFT7UgAFD4Lxa1+uatvFTOo8ovjOJ5s=;
        b=SgbV3zLqhRruFTbg//tkOkORlhZct7p5ADmEHCr+I3JtyZze8/n5J8Fk1T8bL33bP3
         l6K0FXZvvWfVpol6CE0+yv6R/wzjMR9qpYoJxln1rurxdUD0ZN56wT9v+cvoHlIQclR/
         8d3ithsxd4mhf9z3nrvk3Rfm5qaCfz797UJEfA2UDX3NeSMVYf8dGBgdIgev0vWCiVHc
         5W+TbyoPdhoe8FA1fw80ft9Us487c/pfdk99LIhDwfyPweSY1JG9eqL5BPqkQiCHM8Ja
         9PeF4KfuxZRktzO9i4GQGQwMt3/0LWJS3E3MK0ZsxzTHxsyb5m1nEI7xcc1PDkvlvzDV
         Npcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SSA2y7JF1KwXaFT7UgAFD4Lxa1+uatvFTOo8ovjOJ5s=;
        b=CfbiuvPRTGnEQ+uaCq/JoSJ8kkTLlvax7x4M2EHU1Mpr2WvE8yQTyoxXvRVMm054k+
         dnYWSgBy6PYA6UD3yAsPfpmUQBgXHE3mPZog+HspVMMrZWdGpLUjk5L4vhNwAea3jgB3
         Py5twh/Kh2PiAe9qZc9w2ViiMqwjktYplX9VP4pMOPI4UyhLKSyXbeqI7Qpaw5DctvpK
         euqOcbCbCLi3qNQpmz5p7B8RJj3fHZRH8E+yj0MQjjQbQcdv4a3BaZyoOPXCO/bb6caP
         c0TfamAwtPpG32TZWksOqKNXQUZJaG5NBkja9SXp4AcZMgl4W9S4SQME5QW/y1xXnva2
         6y5w==
X-Gm-Message-State: APjAAAW5GXGJGswGGP6Wc/LX8+IujhJmpVUdZz/7GGWX4jJ35Wx+MdaT
        xvVQEwYhGY4vlCkG5xDNwgQ=
X-Google-Smtp-Source: APXvYqyTRQyN/aLx6e8N+a7xJD8PQBFpaACGjWgEy9fJqXILLfEaQjMZIzWAc0KJzbXzeJGgawOWvQ==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr24201388wrq.153.1583157283978;
        Mon, 02 Mar 2020 05:54:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id m19sm15871308wmc.34.2020.03.02.05.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 05:54:43 -0800 (PST)
Date:   Mon, 2 Mar 2020 13:54:42 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/vmscan.c: Clean code by removing unnecessary
 assignment
Message-ID: <20200302135442.ouzmkr2rttxlgixa@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200229214022.11853-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229214022.11853-1-mateusznosek0@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 10:40:22PM +0100, mateusznosek0@gmail.com wrote:
>From: Mateusz Nosek <mateusznosek0@gmail.com>
>
>Previously 0 was assigned to variable 'lruvec_size',
>but the variable was never read later.
>So the assignment can be removed.
>
>Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>


-- 
Wei Yang
Help you, Help me
