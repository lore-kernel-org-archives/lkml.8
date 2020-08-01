Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EFDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78D22063A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW+MdLi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgHABje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHABjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:39:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958B4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:39:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so8080747pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0VhPd8rDv3++vd26X40jpsgWmAZAmnnq5yHGsrWcE7E=;
        b=XW+MdLi1dc2p36sXxUYARFO2yVeTKqRk1GoBDFdp2MS7DtL3DNF9uAFwSVtX7+2+Mu
         Bd/3T5w0Sq2FJoLoSUfXJdJtZHFVJqi0j8KWF+QHHvlHB1SG1JKWALy7SOx/YEdswWar
         yTGvtVP6LN9QUOHPqGJz49jy19NkvM7PzeyBUJD4oAGkk4tNmKhB7NPvY3BWHgw25mCT
         dZQ80s0B/raUzFH2pAtzvRBdptqw4I2ucERK0qcUi4pOIFxeRm3hIMZrIBBaul5u3oLn
         jR5T+bUpVkrenjtzLNT7utN+mClKWenQoxGuiG/9WpFumahLITYuG5+bMN/llVadoMC2
         JUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0VhPd8rDv3++vd26X40jpsgWmAZAmnnq5yHGsrWcE7E=;
        b=nv4yrQkxciFDyE/13XpLJjn06UGcMirrApR8H/lW04kFqsJ/Ohhf7Jmn0jmC3bx1SV
         MaZq6XcY+Eyf7e5mM+oIl041dSoAzPO05vDZcLE2sc/+e4Ahpj7UDUk7b3W+O7G6oC/8
         b1gju0vt0f0Vx3bcvzWUEa3JP+o6NmpcqxLSc4GMbQUMkJTaOH4YXYjXgAeFSAkyBMG6
         gs4kaXzd8HcmPNLMD64mdG3sC/1SfxzYyyKLVw4p4iouwB/SWFJlIA17xTnoLxeNGFGp
         Lur30lnyIApiXJvZrm8Pka8FQT4QrYzOkJat5bCguVH3UBuW20KrdPuMa31HgIZUv0TY
         ev7w==
X-Gm-Message-State: AOAM533CtK6VvvIiSVjGM/nEfiW2OtTIuBwGXgAXg1/jkrtU29uViUN9
        kew94BzvrmxMwDKYIdAO7zg=
X-Google-Smtp-Source: ABdhPJwgvmgH3Bcxkd0vVno/9ycpJ7XegdbDFCTdvKMr3DerT3liFbPy/y+0hTKPhuCxK/E2PoJG+w==
X-Received: by 2002:a62:19c4:: with SMTP id 187mr6053500pfz.312.1596245973013;
        Fri, 31 Jul 2020 18:39:33 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id w130sm7249367pfd.104.2020.07.31.18.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 18:39:32 -0700 (PDT)
Date:   Sat, 1 Aug 2020 10:39:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Replace hidden BUILD_BUG_ON() with
 static_assert()
Message-ID: <20200801013929.GB796@jagdpanzerIV.localdomain>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/31 21:08), Andy Shevchenko wrote:
> First of all, there is no compile time check for the SMALL
> to be ' ' (0x20, i.e. space). Second, for ZEROPAD the check
> is hidden in the code.
> 
> For better maintenance replace BUILD_BUG_ON() with static_assert()
> for ZEROPAD and move it closer to the definition. While at it,
> introduce check for SMALL.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
