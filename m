Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB913C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C310214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580109196;
	bh=rr2uI6+r4ElsfZG9/N7HSzT4yhWF8nb+Voz8rFD3JmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tGLoRuYnBZQLP5eK2cumeVb8K5ZJqZOYE6X/lHQFngrgKjqIL8u+tPWiXxaYg+qv4
	 UTy0CbPcL2fPYXYV3XzeBoiY/YVCgGCI4DdydjYxeF3Ead78aGqux4BR9eLTTBVEoe
	 xaV3v8IPrWstwEyMaTkA6HuEb+vhfJwf3CwIXiHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgA0HNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:13:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgA0HNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 02:13:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737B4214AF;
        Mon, 27 Jan 2020 07:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580109194;
        bh=rr2uI6+r4ElsfZG9/N7HSzT4yhWF8nb+Voz8rFD3JmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0tvhJLGWvxM550jgfs4uRrSCD8n8GLchcxFd9fQaOCFMq1R49cQTy367EkCPWEtOK
         QRCZdieSk9pcC1vl+xnA4LDPOj75Jnh1VIyhNHuxhPyJt01Kqy7FEtqczw+nkFVXSN
         YsflHF5r6hLW5WsKt78YWrxuqhnaVGWlDX+5Vi9I=
Date:   Mon, 27 Jan 2020 08:13:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.6
Message-ID: <20200127071312.GB279449@kroah.com>
References: <20200127064007.GA12713@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127064007.GA12713@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 08:40:07AM +0200, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the pull request for habanalabs driver for kernel 5.6.

It's too late for this, sorry :(

Code needed to be in my tree usually for a week before the merge window
opens before I can add it to that merge window.  This got no testing in
linux-next or anywhere else, so I can't take it.

Feel free to split it up into bug fixes for 5.6-final and new stuff for
5.7-rc1 and I will be glad to take those after 5.6-rc1 is out.

> In addition, I got my pgp key signed by Olof.J. I would appreciate it if
> you could verify it.

Any clues as to how to verify it, is it on a specific keyserver?

thanks,

greg k-h
