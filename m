Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C799C43459
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C46E2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595319526;
	bh=FBJQa3FzkY0nyJqADE7Z/ZHWqoJDA0scjTK50ZIbgFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RKWtx44rTDryRua5m6bhvCp3vmzKVbO7PJ1Zpc95L/PXOIWFWapKBl1lhNMFrB6wg
	 gKOj36zF0BWewy/v7vsSM40Kf7nDaqPei7SWG+M2HkBSw37ecnf++Qf0XAb+srNGrs
	 qbvSCyimHHZSly9DgBl5XCuAMm8hLs83BqP5FWls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGUISp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgGUISp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:18:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2731F2068F;
        Tue, 21 Jul 2020 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595319524;
        bh=FBJQa3FzkY0nyJqADE7Z/ZHWqoJDA0scjTK50ZIbgFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vVb7R8w9/m1ckbQMlt3FV4OuSERrvyMyR3UVQONJDsEG/8OZgrpZyagIHKmNVR1kr
         vo8Cybwvt9s6SU9KWKy0MRjkQCHPcklObClw167H2sikvmcwnDoTpNuGt7oYE2k99c
         AwT8t37gNDWM4zGH14cWPnOqYL7B3/ePWrPVNatc=
Date:   Tue, 21 Jul 2020 10:18:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v5 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200721081853.GB1655283@kroah.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
 <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595301250.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595301250.git.huangqiwu@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 01:59:34PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports the kind of quick charge type based on
> different adapter power.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
