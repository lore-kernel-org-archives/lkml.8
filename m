Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B70AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E912C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597740622;
	bh=WSh7IdELd/eQklKofxE22VupoTK1Na3EH317UJ2UhaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DiBrtBKR+lmztjshCxZJGtZAm5g4ckGi6XTU7q/ULL7fquLbTP9Kc0sc80BAc3sXY
	 L2hKQX/KLMrak+H2hJA7oe2IIjOvbU/SyWp1MLDnEGFt/47BCwrMLPAmGSouqRbjHo
	 fynMEqVkNO5SLi7nBpSnjmt0m+X3mq4IxCj1ryR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHRIuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRIuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:50:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 000052067C;
        Tue, 18 Aug 2020 08:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597740619;
        bh=WSh7IdELd/eQklKofxE22VupoTK1Na3EH317UJ2UhaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aN8ABA5vgyGU+pPMYlsmmmjA7OopSjLw8NuxM64sEyVxXzACO6AQH0qIB6jevECU/
         QZD0x2kUW3otR3TE3ThEZtIgV9hN8LNfZrChdgb/5C2nkQbOrzCgB6bL+JupKTGqVH
         cRc4hSL64NTOpX/qFzIlvbWB67iPjzHQJOVOX9+o=
Date:   Tue, 18 Aug 2020 10:50:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     china_shenglong <china_shenglong@163.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jan.kiszka@siemens.com,
        Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: Re: Re: [PATCH] usb-serial:cp210x: add support to software flow
 control
Message-ID: <20200818085043.GA28036@kroah.com>
References: <20200730075922.28041-1-china_shenglong@163.com>
 <20200730080639.GA216353@kroah.com>
 <386a30c0.ac88.1739eda0ee5.Coremail.china_shenglong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <386a30c0.ac88.1739eda0ee5.Coremail.china_shenglong@163.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 04:32:37PM +0800, china_shenglong wrote:
> Hi, Greg
> 
> 
> Yeah, It mainly adjusts the code style according to the kernel specification,
> and then modifies it according to your previous review comments.

Always include that below the --- line, and version your patches so we
have a chance to know what is going on.

please fix up and resend.

thanks,

greg k-h-
