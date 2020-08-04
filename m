Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8DAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131EA21744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSmsvJyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgHDUs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgHDUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:48:28 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DE3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:48:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m22so860578eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqpbOQVzDCzUgU0urNu9EPIE4Ge9MLfqzEnXxyaLaK0=;
        b=vSmsvJySEicOLbSHzIA6J7MgSzVb0wwZnrCz69Ozrzro7d3Ac1yqFZH0FAfB73KIwY
         8JYwmoBy0NZVisqeb84sLLG/CkCrIjrwrM1XE4HolDbRdylLOvRrwDKWgx8qGEzEJCX7
         zppNPDwiytYQmvHetDGpoJBMfqCPpoxdG9YtpEesl8rGln7bjGSWl9OOJnxr81w5/GNj
         QTUhiusCCh6y1z8gksTYZi5Vl2onOiiaMGavWoSA8LmVVgXrkBQKiHHEZQ2sujUoGs0w
         /4Ix6WtmX4toYoHqZFEFmBgBYybhz8y/7cQqkah6j200r92kY8kaRy5dlF0SEBcW42Rf
         TI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqpbOQVzDCzUgU0urNu9EPIE4Ge9MLfqzEnXxyaLaK0=;
        b=Omm9CaNnnr5gDOjQSqFSCsDiPYHtAm+NqNvXgDcCDYPC0ZYX1JcOeWtEmiksEZAXNH
         166+OFaTMuv+A8dlEYVO8YL+jN4lhEfzLeMlYGATb8XJpQpPkgd2cpfkUO/rkidcgHv/
         J2YUATgy3c8KZDTckbgF0CE7j24KlKSHfkHMAwWvAT8CRSMtJuiA3btjVsftAfyX1YIM
         jS856csdH8OiP4c9S0aEThGGaoRaZ8P4SVxF/yLoBhDksYi66QPkzhEX6sVGXjtLiJxN
         Dbw2peUEO19FhDEv1GhwUVMdoVp76P7Gbfi0LMlPis5FGJ2nZYOwZMIboRragqCWL7zs
         uZeQ==
X-Gm-Message-State: AOAM533yMlIiKY1KubvhxtxvD36SHyrt9LL9kYoguslq3o4OD4PYE7ff
        O3AKQ08IjbshpXfkT0kUOWw=
X-Google-Smtp-Source: ABdhPJwu9MuLWp3ZrRR44iWqE5kIVxrgTONB0odsS9YEKhesx9g3xCecLA/JtmUU+mCFSReF2GgKxA==
X-Received: by 2002:a17:906:1392:: with SMTP id f18mr22686757ejc.521.1596574107347;
        Tue, 04 Aug 2020 13:48:27 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:d068:a44f:fa3b:62da])
        by smtp.gmail.com with ESMTPSA id di5sm78772edb.16.2020.08.04.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:48:24 -0700 (PDT)
Date:   Tue, 4 Aug 2020 22:48:08 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH 3/6] openrisc: uaccess: Use static inline function in
 access_ok
Message-ID: <20200804204808.ttgkwrievzn5aoqd@ltop.local>
References: <20200804042354.3930694-1-shorne@gmail.com>
 <20200804042354.3930694-4-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804042354.3930694-4-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:23:51PM +0900, Stafford Horne wrote:
> As suggested by Linus when reviewing commit 9cb2feb4d21d
> ("arch/openrisc: Fix issues with access_ok()") last year; making
> __range_ok an inline function also fixes the used twice issue that the
> commit was fixing.  I agree it's a good cleanup.  This patch addresses
> that as I am currently working on the access_ok macro to fixup sparse
> annotations in OpenRISC.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Look good to me.

-- Luc
