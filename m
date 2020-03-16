Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5A1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8297206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584380716;
	bh=GfFPEAJ96PQVW/TEMblMoz2dI/DbvaS6Eb3dk99McDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HizAN3rPJ2D/wyS+wi/s/PmcprY+09bcm9mSY7hpW01ne9A5PAzPzDHWjsI53vw6R
	 VsM7B20Cz6gjzK7exnRCb3WFWPgKgiQKFsfCX1MV8mZWxwVffo42jdCCScuOKbSk4m
	 rTs3q+t5fkZM/UYTOOqOAafSv6/aFTER7wHu8qcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbgCPRpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbgCPRpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:45:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 578B520674;
        Mon, 16 Mar 2020 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584380714;
        bh=GfFPEAJ96PQVW/TEMblMoz2dI/DbvaS6Eb3dk99McDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nD9T9enM/fv/bWWZXi6V7pbhTG49uc47IJ1/xmsmAgS1AQPcikbcFZKHqEvacIbRf
         jdF4G+OAbiJLn0Sz4m0XiSGC1/b3C651R2KMRWZhkzGEBAt40IU69XFEPCwNCOzVDi
         WCZPo7uxCIaNbOa4Rs6AC6fmjHpao29/kBpgP/F4=
Date:   Mon, 16 Mar 2020 18:45:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Xin Tan <tanxin.ctf@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu
Subject: Re: [PATCH] VMCI: Fix dereference before NULL-check of context ptr
Message-ID: <20200316174502.GA274042@kroah.com>
References: <1584375516-10729-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584375516-10729-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 12:18:33AM +0800, Xiyu Yang wrote:
> A NULL pointer can be returned by vmci_ctx_get(). Thus add a
> corresponding check so that a NULL pointer dereference will
> be avoided in vmci_ctx_put().
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

You sent 2 different patches with the same subject, yet they did
different things :(

Please fix this up, make them unique, and send a patch series.

thanks,

greg k-h
