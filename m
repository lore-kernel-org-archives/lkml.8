Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D71C43462
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D0222B47
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595524379;
	bh=w4OmY5hcNzQfbvtkqtdBRmZocxa2mmGkh26J/9OPfzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=yHgS5lmv+94JRMklGNXU7e9lBx9TzISNokfDbuZ0Xuqwpv/0cNzBIrDjfLv0oUz2a
	 gVNq8ZTEuVRJQoYhMONdPPuk7bFK/ZUw6k6VaAcYSyPYC3dYPvyNKgKW+GgwdLI5b4
	 dMYFKU1lB6gS7I6OaH5RaqzDcFU8CpbvlnmMEpdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgGWRM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730221AbgGWRMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:12:52 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F55F22BF3;
        Thu, 23 Jul 2020 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595524372;
        bh=w4OmY5hcNzQfbvtkqtdBRmZocxa2mmGkh26J/9OPfzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zqaEaaehTFPl0ZbTqw279ct0PftgMnWx8nM8kHFSkJ4rUXtTeq6dFQqktjFwDOOAh
         tV5BYajYN+T/LOG+0/jMtCPOpcYmt8mwoQC6zxZOcEloA125igFvDcr7r7X0esnyMr
         QIlEQioaIrwImUgR7ylJShWdRycZyQ5CRUrxWBfI=
Date:   Thu, 23 Jul 2020 12:12:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ricky Wu <ricky_wu@realtek.com>, Rui Feng <rui_feng@realsil.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Ettle <james@ettle.org.uk>, Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacopo De Simoi <wilderkde@gmail.com>
Subject: Re: rtsx_pci not restoring ASPM state after suspend/resume
Message-ID: <20200723171249.GA1422397@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723165622.GA1413555@bjorn-Precision-5520>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Jacopo]

On Thu, Jul 23, 2020 at 11:56:22AM -0500, Bjorn Helgaas wrote:
> James reported this issue with rtsx_pci; can you guys please take a
> look at it?  https://bugzilla.kernel.org/show_bug.cgi?id=208117
> 
> There's a lot of good info in the bugzilla already.

Likely duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=198951

Jacopo, could you please attach a complete dmesg log and "sudo lspci
-vvxxxx" output to your bugzilla?
