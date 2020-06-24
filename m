Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCA9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12B220768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592977053;
	bh=wb4QukjekILuiNOvt3WtAggRANvs3/DPlF6kk/OZN9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sgQo/HSXhRNOZVHptv5hEpJ0CpGWSq8D6fpvaG3jZlfgFSTyJhnHx4d2L7aQLtVhE
	 i+FU4NdXFz7q/IsyZowhJMATpO+l/qdnP8VHj9E9oH/WwI7flUn1iVny4hpfrZSX4s
	 6k+P675mn+GwybbbXH2hFy/Cd3a/F7vd+TbC4mD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbgFXFhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388470AbgFXFhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:37:31 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0C82072E;
        Wed, 24 Jun 2020 05:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592977051;
        bh=wb4QukjekILuiNOvt3WtAggRANvs3/DPlF6kk/OZN9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ME2/ILyRl01EO6yDPEjuIw5z41jE6WT0YL/dZxeFp1FPcCqTGoXmWlZASWXMdQg+d
         Gg6ZXHBJaopVsT69BCF292QvgQpMxHWYMvgoHHUbOyO2xDDrO8HZyvDEPplfoZjCZF
         oVsC9NaAewstXOI+yLeiPyQ9MDInXF4S2T12EQBY=
Date:   Tue, 23 Jun 2020 22:37:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v9 1/4] unicode: Add utf8_casefold_hash
Message-ID: <20200624053729.GE844@sol.localdomain>
References: <20200624043341.33364-1-drosen@google.com>
 <20200624043341.33364-2-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624043341.33364-2-drosen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:33:38PM -0700, Daniel Rosenberg wrote:
> This adds a case insensitive hash function to allow taking the hash
> without needing to allocate a casefolded copy of the string.

It would be helpful to add a few more details in this commit message.
Somewhat along the lines of: ->d_hash() for casefolding currently allocates
memory, it needs to use GFP_ATOMIC due to ->d_hash() being called in rcu-walk
mode, this is unreliable and inefficient, and this patch allows solving that
problem by removing the need to allocate memory.

- Eric
