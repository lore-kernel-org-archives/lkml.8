Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C8DC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E125C20768
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586192959;
	bh=jGlWkL5YDyGUqffV9CUBwhs+ieoeBSdeSCJjrAMi7+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vqmVqtb8Kvuee8DxXznNTGRguTnqHrhhEIQE0E5byvzFUqSQ3fdShgwRVzOKmIF86
	 HOaTi7Dv9ZDvlO3mJ5OrDTm9BtzzoCeLCCJQm7eACVR0MlpqdcvNhAEfOvLjKgIuQD
	 ZPTZCXftBsAlyYt7WOeKEUsBJbY1l/B7+/S8VV6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgDFRJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbgDFRJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:09:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F70249C3;
        Mon,  6 Apr 2020 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586192957;
        bh=jGlWkL5YDyGUqffV9CUBwhs+ieoeBSdeSCJjrAMi7+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bX0J7CVKPDu/QIq9uQnf9dItL0Yzl4bDcJcljSzEPOOiqin2OZvTml6CkaO62pLAv
         K9QqMIjQCNhZP4Vpk/GbF7q8Pz6D2vnJplND4/FWUGeSXJmWeg9IhJtUPwDDj71SJz
         lqxG1EHkPqFtMupQgI4o/ezaQW19nu24BhHG4NSc=
Date:   Mon, 6 Apr 2020 18:09:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Introduce ID_PFR2 and other CPU feature changes
Message-ID: <20200406170911.GA7446@willie-the-truck>
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 06:09:03PM +0530, Anshuman Khandual wrote:
> This series is primarily motivated from an adhoc list from Mark Rutland
> during our ID_ISAR6 discussion [1]. Besides, it also includes a patch
> which does macro replacement for various open bits shift encodings in
> various CPU ID registers. This series is based on linux-next 20200124.
> 
> [1] https://patchwork.kernel.org/patch/11287805/
> 
> Is there anything else apart from these changes which can be accommodated
> in this series, please do let me know. Thank you.

The latest Arm ARM also talks about DFR1 and MMFR5. Please can you include
those too? Might also be worth checking to see if anything is missing on
the 64-bit side as well (I didn't look).

Will
