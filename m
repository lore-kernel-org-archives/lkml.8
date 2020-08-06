Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F74206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735145;
	bh=ts0esQvLRrKlkrlQGYaLd1TcRj9apR6dcld9jP7A3Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zuV1KeP5y1TgXqHlEAfuOyxZcfSxaCtDsvetXnueEoysklKUqdRGtXzWxZx1bM8Ht
	 etZ31M0LGsQKwHXseXvFuuNYDdwuXsK9Dg9y0xGzLWQgPHg7BPdcFlb12xa6nH49GO
	 HpbHr3xMGT23TrTOvhnU6O03/WToM1FWeJpTQ/os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgHFRcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbgHFRbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1577D22CB3;
        Thu,  6 Aug 2020 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596712215;
        bh=ts0esQvLRrKlkrlQGYaLd1TcRj9apR6dcld9jP7A3Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZO533dQakrMHDjA3QECJR03uwXz/pk/23ZovJgdHV8jBkH7M9Y0Ttc+WrqU9IbVy
         JHu0JvvlwK8WohHQfuTVtkcPP1giJMl9MJQ8SIFjllMGwKmRYSU9k1IsKd8mbHHA7x
         xfA4PLJRrx1fqhrCJwh2YP9bGop6RDKVQ2FCRGTk=
Date:   Thu, 6 Aug 2020 09:10:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yangerkun <yangerkun@huawei.com>
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com, maz@kernel.org,
        drjones@redhat.com, marc.zyngier@arm.com,
        christoffer.dall@linaro.org, stable-commits@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: Patch "KVM: arm64: Make vcpu_cp1x() work on Big Endian hosts"
 has been added to the 4.4-stable tree
Message-ID: <20200806071040.GA2647685@kroah.com>
References: <159230500664142@kroah.com>
 <6084bc97-11ea-4b7d-086e-fb98880fca6c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6084bc97-11ea-4b7d-086e-fb98880fca6c@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 10:26:24AM +0800, yangerkun wrote:
> Hi,
> 
> Not familiar with kvm. And I have a question about this patch. Maybe
> backport this patch 3204be4109ad("KVM: arm64: Make vcpu_cp1x() work on Big
> Endian hosts") without 52f6c4f02164 ("KVM: arm64: Change 32-bit handling of
> VM system registers") seems not right?

I do not know, can you verify that this is needed and let us know?

thanks,

greg k-h
