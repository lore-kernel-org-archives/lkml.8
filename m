Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7531BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0E72071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598337471;
	bh=QAh1fsG+nfUYLnOVJ2Mf5IAC1jYT0FeqPDpIgb147HQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E8Gjnom04KyQDNMFLPeKqjQIL6UOvTDyx4aU5zAjjI3/o1T0/8YA4J+qV+QAX24PT
	 7CX26NjGjRn0PTF3Uu/LpAWxoJuaRMX9oFbcMbkizuBS7m44J6ZyrvuRvYEHt/X8pC
	 GLfwfo+nmbS5yokuwb5dsqIeFhz0DI0fHOqyTJWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgHYGht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgHYGhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:37:47 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC24BC061574;
        Mon, 24 Aug 2020 23:37:46 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c8so5795896lfh.9;
        Mon, 24 Aug 2020 23:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+8J0SMn0DeaTAP1G5XZRDMqDI4C3yEDmcbeRVLLld+A=;
        b=mnVmkRUn6UwjZ7JzQHaQs097X30CHeAIcUM8gXZJXxbz9UzTWzNWiVADcbcGXiSoR1
         j1g8q7WdR8PMG3RPhh0gPyq13YFsLxQ5CqIMko/XwVPuYAN1JO9+0ROyxmUehRI7Db69
         j7xkhYcXWi0BNsm+Aph+dwIZx7EMkLC8pRSebcsmRMvljJWgE4FVXvrYeLF72yNglF8X
         u+rteBw1n/+ZHQ0+EDI1Pm62AcYOPNSjQ3zNNUl73/gyt8b2R9ZFC+62toNOdfIGWlLJ
         HhPgc8uwkHno/75s5bY4Knmom8kUkSkTw0zDIReRuqVun62no/SnF/Qhp0OyLrt58sQ/
         tgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+8J0SMn0DeaTAP1G5XZRDMqDI4C3yEDmcbeRVLLld+A=;
        b=oRc1GPHDYwsre/2tWHFUFE6zUNLkreB15Jqa3vsBPcXMlMxQHSv9nGAZ1f2fBdKdE8
         qd7ATpQWyLhDhGVwWEH9zvz2SAMhptwd+eDDczOWCGjr18oIKpcHuaC81f5abcrCsRFj
         zKcf02nenBtxCiy2do+SebD9d37CWIFb0wbUpKJDhr46W8/i7qemLhQcD2rrSipR0BJx
         E6dLjpo1+1mhSE51mFreLQ81Qwzeod7/D6Bqk3a67LiNa1OAQ0VeAUsNlC/CZ4/ixJqI
         RxXbtIuZelRoW1BRmfnfEPjxKcyzBlGxD9jQMJ3eHtfG3kTPJEjlSvfGZN1KAtM+Gx1J
         h5UQ==
X-Gm-Message-State: AOAM531RbB3/kM5/buJ5EyjJoRQtlqp/IdtSwhI38VEIcGgl164Cq5W7
        c6oNhk71Ze86w2YyjyHqkZI=
X-Google-Smtp-Source: ABdhPJygsl82djudIj8ldZzBmKIY8fohNI4qVOnN8UerAuDPt0BwxOnPPd5QCHhqoBvJ6EDIa24y/w==
X-Received: by 2002:a19:5046:: with SMTP id z6mr3930462lfj.4.1598337465261;
        Mon, 24 Aug 2020 23:37:45 -0700 (PDT)
Received: from rric.localdomain (31-208-27-44.cust.bredband2.com. [31.208.27.44])
        by smtp.gmail.com with ESMTPSA id d6sm2628099lji.110.2020.08.24.23.37.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 23:37:44 -0700 (PDT)
Date:   Tue, 25 Aug 2020 08:37:42 +0200
From:   Robert Richter <rric@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Subject: Re: [PATCH 02/29] alpha: Avoid comma separated statements
Message-ID: <20200825063742.jopjozosvg5h74fp@rric.localdomain>
References: <cover.1598331148.git.joe@perches.com>
 <4facd57f80c70437f085ba3a1bcf13ae0b63c3bc.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4facd57f80c70437f085ba3a1bcf13ae0b63c3bc.1598331148.git.joe@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.20 21:55:59, Joe Perches wrote:
> Use semicolons and braces.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/alpha/kernel/pci_iommu.c      |  8 +++++---
>  arch/alpha/oprofile/op_model_ev4.c | 22 ++++++++++++++--------
>  arch/alpha/oprofile/op_model_ev5.c |  8 +++++---
>  3 files changed, 24 insertions(+), 14 deletions(-)

For oprofile:

Acked-by: Robert Richter <rric@kernel.org>
