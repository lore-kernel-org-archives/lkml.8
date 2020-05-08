Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB93C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1952082E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEHAFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 20:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbgEHAFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 20:05:19 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9739AC05BD43;
        Thu,  7 May 2020 17:05:19 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWqVp-003JlK-Li; Fri, 08 May 2020 00:05:09 +0000
Date:   Fri, 8 May 2020 01:05:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     axboe@kernel.dk, zohar@linux.vnet.ibm.com, mcgrof@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: avoid fdput() after failed fdget() in
 ksys_sync_file_range()
Message-ID: <20200508000509.GK23230@ZenIV.linux.org.uk>
References: <cover.1588894359.git.skhan@linuxfoundation.org>
 <31be6e0896eba59c06eb9d3d137b214f7220cc53.1588894359.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31be6e0896eba59c06eb9d3d137b214f7220cc53.1588894359.git.skhan@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 05:57:09PM -0600, Shuah Khan wrote:
> Fix ksys_sync_file_range() to avoid fdput() after a failed fdget().
> fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
> in fd.flags. Fix it anyway since failed fdget() doesn't require
> a fdput().
> 
> This was introdcued in a commit to add sync_file_range() helper.

Er...  What's the point microoptimizing the slow path here?
