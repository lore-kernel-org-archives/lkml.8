Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E8FC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7DC215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599461296;
	bh=ufd2DLX/R0fujTE90EimxEtnJx1MNLG4uLbfR18pQJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pfp1EPhJOzC8NiGMa6R6kNUB+5Pb6XokfQI9wulcNmuzvrYjhLtvXuOKThRHROQNP
	 Lvj02of3M5UWkUhu3RRzckPzvlzuzmWU80YzRCE4HksJmipOavwbqqt4BpeuoE6ph4
	 O5DammYVyWDZLyqfwKNxW0itRSGP0IotZQThWo8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIGGsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgIGGsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:48:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB22721556;
        Mon,  7 Sep 2020 06:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599461293;
        bh=ufd2DLX/R0fujTE90EimxEtnJx1MNLG4uLbfR18pQJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yWMxjEhH/R/l9+Xyly2DPiIo5+q/7J6aYd1yKFNFHuPDKJI6kvtm7mbZmTEHLsSRB
         JN62ad9/7FTEHmTb0FtvLPFf6G64wWTfFeG2uk58dyydGbtw8VJ+3BCPfdVBznbIlW
         d9znNPAZnChcisz9u1FWOUz0fbBhysr6JGhncQww=
Date:   Mon, 7 Sep 2020 08:48:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Linux-kernel-mentees] [PATCH v1 1/2] video: fbdev: aty:
 radeon_pm: remove redundant CONFIG_PM container
Message-ID: <20200907064810.GB284261@kroah.com>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-2-vaibhavgupta40@gmail.com>
 <20200907063347.GB29062@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907063347.GB29062@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:03:47PM +0530, Vaibhav Gupta wrote:
> 

Why did you send empty emails out?

greg k-h
