Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B34C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9194C20759
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595078712;
	bh=054o/hzKh+fh2yMScP+42l+JRCfK/PUTSBscQr3uoXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GscCH1cNoZPKrUnEnNcGoXA4zwoi4nIQRSHfoz6wcFtbhgMB2N30J16Ogm6o/VDke
	 n5OrHxTA4w2QWPNhvPqp8Y0SdOhZOtEp07wMPwGNM3NwB9BtI9Q6k3gqxzFfDWqV1P
	 XfEt+lgZdAy261QAynPqlm8EZ1imGfCcYiif2/Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGRNZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgGRNZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:25:10 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC5BC2070E;
        Sat, 18 Jul 2020 13:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595078710;
        bh=054o/hzKh+fh2yMScP+42l+JRCfK/PUTSBscQr3uoXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+lSXAvqJc0sp6x5v+IGz894qsOE9b7M2Z8yUzur0d11pQiLbJ5WwhWS+PztzwqEX
         7T0xE19XqL6pueWWnhn0OqdkerI1OgLyus4g04qhuCFzGTBZwn64wjX1cmbhXm0Lcm
         YaXVZ81M6yu38WaQMaRxv9cxODtevfzbGcKcEx+M=
Date:   Sat, 18 Jul 2020 18:55:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: linux/dmaengine.h: drop duplicated word in a
 comment
Message-ID: <20200718132506.GN82923@vkoul-mobl>
References: <06e64046-ebf1-15db-dbaf-73698de3b493@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06e64046-ebf1-15db-dbaf-73698de3b493@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-20, 19:51, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled word "has" in a comment.

Applied, thanks

-- 
~Vinod
