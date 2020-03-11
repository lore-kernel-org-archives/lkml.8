Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE74C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782D92074D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583959306;
	bh=ERTgvUzz42IK7oH7vR27SuYNGUiszAszjN9WdQ4vyE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EDOwG38aqDzrovMiI/1EYQurys65dEosT4BmxyFRyvO0VMLsQsUbFLRh6xphV+x/s
	 /bXibeJY4ShFu9w3Ag19KEXlbVgLtFLl2JvPhrAOrNz4lrghqZMNLWPMZFsb6h6wck
	 003rE4F9SdzsdI3ea05eiokboVvyDp+yFvG1WayE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgCKUlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgCKUln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:41:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D752074C;
        Wed, 11 Mar 2020 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583959304;
        bh=ERTgvUzz42IK7oH7vR27SuYNGUiszAszjN9WdQ4vyE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zmxyDbDUSj18nG97NX7wy2U/X7kkYjUS06flM7KuL9TXp6YH5eL9gqh6kiW2S5f8o
         N6ya5lgM2ruFG5iF59jN3o9UaP/uJk4PVF6s2WTCfbNZLtrHrjpd4Z5FOZmTysLBmg
         9T2rR19EJZ92sHn5/7xml5fUkiOBV0Rp8M/sO7Zo=
Date:   Wed, 11 Mar 2020 21:41:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/168] 5.4.25-rc3 review
Message-ID: <20200311204140.GA4092098@kroah.com>
References: <20200311181527.313840393@linuxfoundation.org>
 <29932109-860d-3e2e-d15a-05193105fc34@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29932109-860d-3e2e-d15a-05193105fc34@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:09:47PM -0700, Guenter Roeck wrote:
> On 3/11/20 11:18 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.25 release.
> > There are 168 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 13 Mar 2020 18:14:21 +0000.
> > Anything received after that time might be too late.
> > 
> 
> m68k:allmodconfig, for v5.4.24-169-g005c542:
> 
> drivers/gpu/drm/virtio/virtgpu_object.c:31:67: error: expected ')' before 'int'
>    31 | module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
> 
> Hmm ... Makefile says this is -rc3, but I don't see any improvements.

Odd.  It's late here, I'll work on this in the morning...

greg k-h
