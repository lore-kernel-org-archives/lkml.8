Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC14C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA3D2469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgB0Xk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:40:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50164 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbgB0Xk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:40:57 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7Slz-0027E7-Iv; Thu, 27 Feb 2020 23:40:55 +0000
Date:   Thu, 27 Feb 2020 23:40:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] exec: remove comparision of variable i_size of type
 loff_t against SIZE_MAX
Message-ID: <20200227234055.GF23230@ZenIV.linux.org.uk>
References: <20200227233133.10383-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227233133.10383-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:31:33PM -0800, Scott Branden wrote:
> Remove comparision of (i_size > SIZE_MAX).
> i_size is of type loff_t and can not be great than SIZE_MAX (~(size_t)0).

include/linux/types.h:46:typedef __kernel_loff_t                loff_t;
include/uapi/asm-generic/posix_types.h:88:typedef long long     __kernel_loff_t;

And boxen with size_t smaller than long long do exist.  Anything
32bit will qualify.  Pick any such and check that yourself...
