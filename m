Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D614C35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95A2206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582472488;
	bh=CPPKAiwv2Ch+5FYrbANKa1FyHjhbUEMi8lingadkdBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pPaDUfhNtSLFUc3iS7y7MB/j5ktTE5djxll88/PElkCMG74u/dYRg5TE9gXFhSZ0P
	 1SF6k5Oa5IkpDSfMVnFs2lHeHUAHKRz7c4q1hQrP5GIpONmQvDdrKWSw4OGgaJPltE
	 yYEqCh6PQ+rxcjVyf52U0u4fpY9wPeUP1FbzJXPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgBWPl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 10:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgBWPl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 10:41:26 -0500
Received: from localhost (95-141-97-180.as16211.net [95.141.97.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0558C206E0;
        Sun, 23 Feb 2020 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582472484;
        bh=CPPKAiwv2Ch+5FYrbANKa1FyHjhbUEMi8lingadkdBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMzF2CS4jtSOHHlaDIN29aCtr7mDkVdt4y7sVsRdXRmtzAVJ2T9oXT60scEBRoIS6
         k5qAAXluz2KqJP8wyS6LlnwkP8lPNTcoy4VoQarwA9MzXXNXh1auguxhNCcxkJE5b5
         S3uzuTZ/7Umsb/4XAScfH1T6Sldw7xU88dObzcXM=
Date:   Sun, 23 Feb 2020 16:41:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/191] 4.19.106-stable review
Message-ID: <20200223154121.GC131562@kroah.com>
References: <20200221072250.732482588@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 08:39:33AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.106 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Feb 2020 07:19:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.106-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.

-rc2 is out to hopefully resolve the reported problems with -rc1:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.106-rc2.gz

thanks,

greg k-h

