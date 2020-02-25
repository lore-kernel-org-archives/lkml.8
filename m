Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB1BC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE5821744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYGDfqYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgBYP0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:26:38 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40433 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731045AbgBYP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:26:38 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so9283501qto.7;
        Tue, 25 Feb 2020 07:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=H5kUr4WgG5k1LEucWvuIak3cpghudmmXGC7oOGdqPbk=;
        b=gYGDfqYhI6CblUaeYI8E3MeDfmQgcIT8v8EovacTuGUau4nPzHgHe7GX/1ZkHNVF2J
         FnNgR+PlKesX4PLdBiBvV73IUmckY34N+ImMaV5wM+wBEquaKuJ8DRH4cxuau/jJDBOA
         WDrpfGlSPDWpAIeqhyKf73D6WRfYi0wArGnvVl635zK3jfzbug2sB7efJoDESXTEDWgK
         ze/kHP/cKhkET1nfA2vCSVU1TxmhgnUblZowGHBBYjDXA2d4ryjYJBIRkXed9V+/5TTv
         oFn769JeU6Zh/idQC1MeKFo2UirguAdXUYeAosJQJzoTMN6lXoPQi5TkZaYf3lprsXA8
         jNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=H5kUr4WgG5k1LEucWvuIak3cpghudmmXGC7oOGdqPbk=;
        b=KJ8B59rXSJKyv8Yq7pglQy8QOQeIxfNUzbsq3lxXP27CA7Yg0nNaT98anSABV61olH
         4m7J9jWOj4C3qldQJUchOdzEw8Z/LH8DNwg+Qc/hIrnUFyOukyIzwqjWtTugOweJoNAK
         x2x/lx+Yk6mXxzrxdVoPJCaXgkqgxyew5czUVJ1T3h38TIiPLidm1EabQ6ln4xbhBlNH
         C+75H28re2cM7a7G0fWXwWUWln2P7ZlcIJXjodgOSQeudd9YeLseRnDgqmsuJTBrpcnJ
         XJn6NKp4hQhX7xdAfYAmGGcImEe7FJf6iODZQDbyVeccQjAVueH3nD9xDkwzqWRZYa7M
         kVYQ==
X-Gm-Message-State: APjAAAXDaEBBhYFUsnI4ia6XKvYZoF7c+vKzzkMzDaEPAoTVeruNHsuB
        NRsPQSRBY+6B2gY1ZXhTi0M=
X-Google-Smtp-Source: APXvYqzybx+PNry2egFgTpfH6UMHL5FHMxBzLoEBVUQAx82cp2spJWn7wXoG3PrBL+hN+WDxbLAX4Q==
X-Received: by 2002:aed:2ce4:: with SMTP id g91mr53812077qtd.352.1582644396156;
        Tue, 25 Feb 2020 07:26:36 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id w48sm889934qtc.40.2020.02.25.07.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 07:26:35 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:26:34 -0500
Message-ID: <20200225102634.GB5861@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] Revert "net: dsa: bcm_sf2: Also configure Port 5
 for 2Gb/sec on 7278"
In-Reply-To: <20200224234427.12736-1-f.fainelli@gmail.com>
References: <20200224234427.12736-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 15:44:26 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> This reverts commit 7458bd540fa0a90220b9e8c349d910d9dde9caf8 ("net: dsa:
> bcm_sf2: Also configure Port 5 for 2Gb/sec on 7278") as it causes
> advanced congestion buffering issues with 7278 switch devices when using
> their internal Giabit PHY. While this is being debugged, continue with
> conservative defaults that work and do not cause packet loss.
> 
> Fixes: 7458bd540fa0 ("net: dsa: bcm_sf2: Also configure Port 5 for 2Gb/sec on 7278")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
