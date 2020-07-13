Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A7CC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64433206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594629510;
	bh=sJPslYojoRgx0zLon4IrNTWOSSq0CbniTN6vn4XRxNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rFMzMF/EoubSQv6rRbi732wxtICGltMh2jKQPHwk/ZXbp3EEcxoeEZffKW2E2KwQ7
	 RddfIyMhs0a5NlgShPueI05xY2+h75BoXF31N1LpvQGUspW6HZK0IksyPjx7Fr/906
	 COHadBOENFe4FncMKohkpSo9zb1w/aqEfkGdfx0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgGMIi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgGMIi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:38:28 -0400
Received: from localhost (unknown [84.241.194.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D86B22065D;
        Mon, 13 Jul 2020 08:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594629508;
        bh=sJPslYojoRgx0zLon4IrNTWOSSq0CbniTN6vn4XRxNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZupFqVvJpLcsApMVFPBDW62BfmjXbN4IPOcoXX0N316toLcduF6sQwnYtrEWANfdi
         tL7B39pIXw4mnaGpsMSTWESyeOQ+noSMwCoZ2k9C0IEp3Lx5LfL/DWbdjUglF02t8z
         Y33VXq5+/bVPR/lczAF/uhB3MYq/Kv1MPltcECJ8=
Date:   Mon, 13 Jul 2020 10:38:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: allow ->read_iter on debugfs
Message-ID: <20200713083824.GB215949@kroah.com>
References: <20200713073729.875584-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713073729.875584-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 09:37:28AM +0200, Christoph Hellwig wrote:
> Hi Greg,
> 
> in my filesystem set_fs removel series I convert the seq_file interface
> to be iov_iter based.  It turns out debugfs needs this little patch
> to proxy read_iter as well.  Let me know if you are ok with me queueing
> this up with the rest of the series.
> 
> 

No objection from me, please do so!

thanks,

greg k-h
