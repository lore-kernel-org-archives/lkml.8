Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59194C11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2851D20659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582215135;
	bh=7sh9tmZCNa/XG2MFk6jwAzLZ290b8gu6jJpshQH8oBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uoSBmD8P/xWc0l1xFwp0NjCuVd5eDYkOQsBGnwtsicdKj/EuH7g3tmbuwPr9PIiol
	 UrTKbgtu/8z96zw/ISxta8rH3l3/xIZL18Z5V4moScYlx/tsstJ3Gbr5CNx/arm9cJ
	 JX5ndp+46IDTXpenJm2cQ7si/Z+D0zTijnWBACRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgBTQMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:12:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgBTQMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:12:13 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CF9B20658;
        Thu, 20 Feb 2020 16:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582215133;
        bh=7sh9tmZCNa/XG2MFk6jwAzLZ290b8gu6jJpshQH8oBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tw6lme9cckLT8eZtoLZ70Lm5AzuDcvbStw+EMEzKYsN1j6lkpTcp5avqdF8UJRLUF
         Jv2+WimGHRjAJYL9cy6ojcPmcejgLEosDQKOYH6yUcHM1c6tvZTJa9A1rTAQUU+49O
         cNPyqrZk/gATUiD+2SQgllJOlko0vPz4wcLJqCDw=
Date:   Thu, 20 Feb 2020 11:12:12 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH AUTOSEL 5.5 096/542] powerpc/powernv/ioda: Fix ref count
 for devices with their own PE
Message-ID: <20200220161212.GC1734@sasha-vm>
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-96-sashal@kernel.org>
 <0867167a-73b8-0735-78ce-0d984f7a80b5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0867167a-73b8-0735-78ce-0d984f7a80b5@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 09:49:41AM +0100, Frederic Barrat wrote:
>
>
>Le 14/02/2020 à 16:41, Sasha Levin a écrit :
>>From: Frederic Barrat <fbarrat@linux.ibm.com>
>>
>>[ Upstream commit 05dd7da76986937fb288b4213b1fa10dbe0d1b33 ]
>
>
>Hi,
>
>Upstream commit 05dd7da76986937fb288b4213b1fa10dbe0d1b33 doesn't 
>really need to go to stable (any of 4.19, 5.4 and 5.5). While it's 
>probably safe, the patch replaces a refcount leak by another one, 
>which makes sense as part of the full series merged in 5.6-rc1, but 
>isn't terribly useful standalone on the current stable branches.

I'll drop it, thank you.

-- 
Thanks,
Sasha
