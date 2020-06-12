Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA32C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9680D2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591970994;
	bh=q4krEbdPco7MsiBYtM/F7P1LJc3hlmshAKjwldfNwTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vcBJfPEX3qgsYmTSQkYljq/TYU2zBj8jiIS6nF3TKN6hO3gxigfGv2CYPfikNEMM0
	 Co0W3dD5Ia4NphqGWuTnEi2bL3haeiLP8eO4ZJRXz39Ch7wi56YkdtkXHn5IciOsHH
	 r9YmMX/D3bj8+Ymv+9I38JzJHeEW+nxe3xW04cb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgFLOJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLOJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:09:52 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A413E20801;
        Fri, 12 Jun 2020 14:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591970991;
        bh=q4krEbdPco7MsiBYtM/F7P1LJc3hlmshAKjwldfNwTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWcomgAeMEBeuf76DvFJWGzTcD6h7N9jQN02h3R/5OvMUTq1SF90tAwLFZwrkJD7E
         y0GOwgmPmcv99vcGGRWnK0F3C9WfbA9yKKdzL5kLM4ePW7hb7RBsW/cXmoHrMy/6dI
         iUEs14NqIWBrVrzR/6dY5nYghwwVvSdi0wegyHdo=
Received: by pali.im (Postfix)
        id B0786582; Fri, 12 Jun 2020 16:09:49 +0200 (CEST)
Date:   Fri, 12 Jun 2020 16:09:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH v4 0/3] platform/x86: dell-wmi: new keys
Message-ID: <20200612140949.523opfqkxfv3x5cx@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591811549.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1591811549.git.y.linux@paritcher.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 June 2020 13:56:55 Y Paritcher wrote:
> change since v3:
>     No code changes.
>     Update commit message to reflect info given by Mario at dell.
>     
> Is there anything more i have to do for the patches that were reviewed
> or will they be picked up by the maintainers?
> Thanks
> 
> Y Paritcher (3):
>   platform/x86: dell-wmi: add new backlight events
>   platform/x86: dell-wmi: add new keymap type 0x0012
>   platform/x86: dell-wmi: add new dmi mapping for keycode 0xffff
> 
>  drivers/platform/x86/dell-wmi.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> -- 
> 2.27.0
> 

I'm fine with this patch series too.

Reviewed-by: Pali Rohár <pali@kernel.org>
