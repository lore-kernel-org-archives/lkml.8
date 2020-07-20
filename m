Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE60C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00C522CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgGTNAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:00:39 -0400
Received: from verein.lst.de ([213.95.11.211]:46803 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbgGTNAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:00:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67FD668BFE; Mon, 20 Jul 2020 15:00:36 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:00:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        rjw@rjwysocki.net
Subject: Re: [PATCH] configfs: Use flush file op to commit writes to a
 binary file
Message-ID: <20200720130036.GA32363@lst.de>
References: <20200716225517.29522-1-lszubowi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716225517.29522-1-lszubowi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the configfs tree.
