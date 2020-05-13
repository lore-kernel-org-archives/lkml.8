Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA51C2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605AF20753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589369866;
	bh=Amv7ClRMH2P+UI3l2B5270/ACCIOxjyfdce/BpqOoTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fg+dZOwRBphdml9IEUHXsbrkCGZ6gIhI4XGGeV12wu/MV9gXTs8IMJFu+Om4CV7l2
	 WK7i8z4xRKer9uUpABvYaCpX26yD4vcXmeITk9U550msapHbF/oLfLRTCXG7UQxzNL
	 tmMKbcucvnVW/1d7h3rXEkxEG0uvVBSTrO85qacE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbgEMLhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgEMLhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:37:45 -0400
Received: from localhost (unknown [106.200.233.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33EF7206D6;
        Wed, 13 May 2020 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589369865;
        bh=Amv7ClRMH2P+UI3l2B5270/ACCIOxjyfdce/BpqOoTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mfre/YeCy6QGwcr1Joz5kiu6wC7c9bN0saDvow8+/oqfy5oYhM7+lYCakrlu0p6f+
         GuEIUYwThHzDzmwTRdutNYrqWaRKyn5f4Go1mLbAheINq1UyThfjbnheN+l+s+Uo0i
         0CWuIQde9tkxBvs2iFZw3a44LaQecEgQcrbOX1VU=
Date:   Wed, 13 May 2020 17:07:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     green.wan@sifive.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sf-pdma: Simplify the error handling path in
 'sf_pdma_probe()'
Message-ID: <20200513113741.GG14092@vkoul-mobl>
References: <20200501100824.126534-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501100824.126534-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-05-20, 12:08, Christophe JAILLET wrote:
> There is no need to explicitly free memory that have been 'devm_kzalloc'ed.
> Simplify the probe function accordingly.

Applied, thanks

-- 
~Vinod
