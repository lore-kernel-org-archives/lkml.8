Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1BDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838F420734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="LqHOcWua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbgFIRTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgFIRTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:19:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020A3C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 10:19:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so10376535pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pS3fXxlqQZ1qpuPBeNYDB/9xxIJhEcPh7OngVI7wDQM=;
        b=LqHOcWuaretR3F7j6V1cZg3Pe+dpy0Uucy+WLGNPBzxuUK+GR+f4ut+G6xbh0LURpd
         O1UA4aPP4qREUSmh9IWCn0ckBp2l9czR5ryTYPGYNeyddQ2pKIuP3T7ZuCriqrxTBXY6
         mb4WY1gHj1MNX4S7C9ldXj5VzqtIYzIU6xvOFch9/jzXbYwqIVupOg7sIf4oi+MXFYfM
         yEccXskW7tkw54JxFhTZvYESrno7n1ufHuVkbPq/rklcFioiA0pKWsu042fwJzmQ5o6M
         1kZxDUaLeUSMUXd3LF2rqPwSWlSbf+eZ9ebCLb2b6WZ5rmVQkPp18x8tcCoDs49KE4WE
         INyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pS3fXxlqQZ1qpuPBeNYDB/9xxIJhEcPh7OngVI7wDQM=;
        b=JfSrKt7NGFlDOdIXnyHDCRHkysCUivJHta5RFScLisJEfWi0Yvmr5p1MHoNdgDCcJj
         JzoD2toV0H75x/BHBYY+2WyUeLl087nzuhL9aEZhgvfvRLGHU2wjY6lmnxoILUCxgG7B
         VHF4ztYtjF8scykNck8TmjHVlwuQW6E2ttnfQaDw0KT4fVjbdj+/SaA0FwIPv8ytJbWI
         1FdNWMgP+lEfRCvohHKGQ4hYCAcF/bRrp1JMUFLQWG85P916SOPnfSGW/NL2tiRa2wwA
         YsCFGo09nRqugaTD2IF5yqpPhJZLauEq8KXIoE6Feucg8x6LGT55LIiWtP2OEuVKNItd
         FE/A==
X-Gm-Message-State: AOAM530j6TRTuxJDTMP7EJ8oKg5mw87IS9AWhpJ9+p9TBVGsWu21eeOS
        nfM+o9/VYGbRAQzJqCjX3zVrFQ==
X-Google-Smtp-Source: ABdhPJzUWQw08dzF+hQyYORg3Kzta5U3cP3gTCT2NcJJzsUgAa6pwkXSNLsSb6HZi1DU032775KyKA==
X-Received: by 2002:a05:6a00:1494:: with SMTP id v20mr26724761pfu.150.1591723185179;
        Tue, 09 Jun 2020 10:19:45 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id i37sm1935829pgl.68.2020.06.09.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 10:19:44 -0700 (PDT)
Date:   Tue, 9 Jun 2020 10:19:35 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     David Miller <davem@davemloft.net>
Cc:     o.rempel@pengutronix.de, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, kuba@kernel.org, corbet@lwn.net,
        mkubecek@suse.cz, linville@tuxdriver.com, david@protonic.nl,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@armlinux.org.uk, mkl@pengutronix.de,
        marex@denx.de, christian.herber@nxp.com, amitc@mellanox.com,
        petrm@mellanox.com
Subject: Re: [PATCH ethtool v1] netlink: add master/slave configuration
 support
Message-ID: <20200609101935.5716b3bd@hermes.lan>
In-Reply-To: <20200607.164532.964293508393444353.davem@davemloft.net>
References: <20200526091025.25243-1-o.rempel@pengutronix.de>
        <20200607153019.3c8d6650@hermes.lan>
        <20200607.164532.964293508393444353.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Jun 2020 16:45:32 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <stephen@networkplumber.org>
> Date: Sun, 7 Jun 2020 15:30:19 -0700
> 
> > Open source projects have been working hard to remove the terms master and slave
> > in API's and documentation. Apparently, Linux hasn't gotten the message.
> > It would make sense not to introduce new instances.  
> 
> Would you also be against, for example, the use of the terminology
> expressing the "death" of allocated registers in a compiler backend,
> for example?
> 
> How far do you plan take this resistence of terminology when it
> clearly has a well defined usage and meaning in a specific technical
> realm which is entirely disconnected to what the terms might imply,
> meaning wise, in other realms?
> 
> And if you are going to say not to use this terminology, you must
> suggest a reasonable (and I do mean _reasonable_) well understood
> and _specific_ replacement.
> 
> Thank you.

How many times have you or Linus argued about variable naming.
Yes, words do matter and convey a lot of implied connotation and meaning.

Most projects and standards bodies are taking a stance on fixing the
language. The IETF is has proposed making changes as well.

There are a very specific set of trigger words and terms that
should be fixed. Most of these terms do have better alternatives.

A common example is that master/slave is unclear and would be clearer
as primary/secondary or active/backup or controller/worker.

Most of networking is based on standards. When the standards wording changes
(and it will happen soon); then Linux should also change the wording in the
source, api and documentation.


See:


[0] - <https://www.cs.cmu.edu/~mjw/Language/NonSexist/vuw.non-sexist-language-guidelines.txt>, <https://twitter.com/justkelly_ok/status/933011085594066944>
[1] - <https://github.com/django/django/pull/2692>
[2] - <https://bugs.python.org/issue34605>
[3] - <https://github.com/rust-lang-deprecated/rust-buildbot/issues/2>, <https://github.com/rust-community/foss-events-planner/issues/58>
[4] - <https://twitter.com/ISCdotORG/status/942815837299253248>
[5] - <https://gitlab.gnome.org/GNOME/geary/issues/324>
[6] - https://mail.gnome.org/archives/desktop-devel-list/2019-April/msg00049.html
[7] - https://www.ietf.org/archive/id/draft-knodel-terminology-01.txt
