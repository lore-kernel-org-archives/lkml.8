Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7387C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7577520776
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585575428;
	bh=ayBEhF0emKa95SIxiPEA4fE7OhgG5vRQ/2ittLcRunY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rHjoyGYYgBQt6CSUfxjXxHoHW0Pq17nuyfB7Ldtt/Ce7fVGnB2PoNG4x09N2/EHpa
	 uNkJton4wszuI36rfGH2HEC5vSLHCll1VB6QRlK7hD+FGNqfHMIf0SIKZlVzxoEAp6
	 scv7hHv/B0IVbq5ByoKmNnyV7ra/AGK//nsKUPpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgC3NhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgC3NhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:37:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F31920757;
        Mon, 30 Mar 2020 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585575426;
        bh=ayBEhF0emKa95SIxiPEA4fE7OhgG5vRQ/2ittLcRunY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGHMfbZXHzvQVU69kiYX6HgE+R/J/bX7CBzjc+p92oGXZg5m5xjUo7qDrj8UgO9w4
         E5sKbb1Ufj3uzcosCtLnlRmKX6Tl8cnJ02XOLM+ITto9bZlaGQdCCM1yR2QlDzWJZt
         Vzo3XO29jIjmVwuCUQZ82WbNrp2nqBK6YOKU3og4=
Date:   Mon, 30 Mar 2020 14:37:02 +0100
From:   Will Deacon <will@kernel.org>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 39/50] arm: kexec_file: Avoid temp buffer for RNG
 seed
Message-ID: <20200330133701.GA10633@willie-the-truck>
References: <202003281643.02SGhMtr029198@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003281643.02SGhMtr029198@sdf.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 10:45:27AM -0500, George Spelvin wrote:
> After using get_random_bytes(), you want to wipe the buffer
> afterward so the seed remains secret.
> 
> In this case, we can eliminate the temporary buffer entirely.
> fdt_setprop_placeholder returns a pointer to the property value
> buffer, allowing us to put the random data directy in there without

s/directy/directly/

> using a temporary buffer at all.  Faster and less stack all in one.
> 
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Please let me know if you'd like this queued via the arm64 tree, as it
appears to be independent of the rest of this series.

Will
