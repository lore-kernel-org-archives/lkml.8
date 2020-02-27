Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F9C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A68246B4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrt9AvuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgB0N3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:29:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34041 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgB0N3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:29:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id t3so1496862pgn.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6qXS1wSxw6vDTcttyVtlLNJ03skjYv/jVjoYtks20E=;
        b=Lrt9AvuLeb9jeVeqLm8sfmFsu+KF47C0RipoVstxmDSMD+LYcUnkQ9WYUql+DWq0MV
         lLAVA/qmKK87xKLgsV5unf8vquJltLNFOH9tIXLZdhiC0/X5Kyspr5LgP9XyOSmL2tNr
         ctUvgjNimS8EAc2ayJ3GlFlWzXEICybNOI03niRlE76FSlsK2SLONOa2kwEfQN6fpmk1
         VAcjd+zBE+I8Y4zoeWWcpUAwi3CXlPZAuCogKfv0ETD6ggHBst34Sw0WUJi0BkKK+Gox
         eqk0nXsLlfv22RCqse+bzyO3XlVAo9QTzEgn0sSTjvyt6aio/6WEgduQGDQu5GSF/+eO
         j+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6qXS1wSxw6vDTcttyVtlLNJ03skjYv/jVjoYtks20E=;
        b=n0i8liF26zPsKbEDgTxIZpuMk3MdDG1p3dlItqRoykDuGT4JGBpYPKAZAIbOJ2bxbN
         edBfBVfFsCBtDYdH2jR2oOervTD3Ht6Y8+bbZNg+h9x+fHSZ/fI2BVzBU+RY6Z/vkvGQ
         LYbaxgTM8TrlKcN3s46oDmqXaSeJCudeZCrzBwYekA08ylCA3V/60jPcx0l2mK5P+Krp
         QIUSIsvf38ND52R+J61VewJWm+H1Q+UoQy8vQ4z2Cp6TeETP83xnIGrX1+fBRySiaef/
         0X1B+eEc90DI6YQuzzSH+SlukXKZpwEs9+7/Q18yEsd4eVt3z6w6aJKCY4nkyC/b+7Cl
         TYlg==
X-Gm-Message-State: APjAAAUrD0M9X9qRCt2yux3KUybsASHowWc34bNcSgAeIrXwd5x04mgb
        DHyIA5Fw2/ttiloRDiNmbGq42Ab2GU8=
X-Google-Smtp-Source: APXvYqz+Y5xmU0t4GXQu1hmoMQ0gDOlSlB1DKLqEr4yP3nPm0JTRyMcnK1DuzL7jcjd9v6+CTEqXnA==
X-Received: by 2002:aa7:946b:: with SMTP id t11mr3998714pfq.57.1582810151046;
        Thu, 27 Feb 2020 05:29:11 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id r145sm7553229pfr.5.2020.02.27.05.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:29:10 -0800 (PST)
Date:   Thu, 27 Feb 2020 22:29:08 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 2/3] openrisc: Enable the clone3 syscall
Message-ID: <20200227132908.GI7926@lianli.shorne-pla.net>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200226225625.28935-3-shorne@gmail.com>
 <20200227122147.rnpzcy7rjexgy6yx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227122147.rnpzcy7rjexgy6yx@wittgenstein>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 01:21:47PM +0100, Christian Brauner wrote:
> On Thu, Feb 27, 2020 at 07:56:24AM +0900, Stafford Horne wrote:
> > Enable the clone3 syscall for OpenRISC.  We use the generic version.
> > 
> > This was tested with the clone3 test from selftests.  Note, for all
> > tests to pass it required enabling CONFIG_NAMESPACES which is not
> > enabled in the default kernel config.
> 
> For OpenRISC, I assume. Hm, maybe we should fix the tests to skip when
> CONFIG_NAMESPACES is not enabled.

Yes, not the default for openrisc defconfig.  It might make sense to either skip
the tests of have them as expected fails when CONFIG_NAMESPACES is off.

On the otherhand, I am not sure if the self tests know about the CONFIG_*
available.  I notice many test directories have a 'config' file and a readme
saying, for these test to run ensure use have at least 'these' config values
set.

-Stafford
