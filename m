Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC81C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C841D207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbgG1SE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:04:27 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:39370 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732143AbgG1SE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:04:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7BA03100E7B51;
        Tue, 28 Jul 2020 18:04:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stove18_0203bed26f6b
X-Filterd-Recvd-Size: 1690
Received: from XPS-9350 (unknown [172.58.27.230])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jul 2020 18:04:22 +0000 (UTC)
Message-ID: <0e9fee846ac0fb28df4098e6d577e9090be38ed9.camel@perches.com>
Subject: Re: [PATCH] staging: android: ashmem: used const keyword
From:   Joe Perches <joe@perches.com>
To:     Dhiraj Sharma <dhiraj.sharma0024@gmail.com>,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Jul 2020 11:04:20 -0700
In-Reply-To: <20200728175935.2130-1-dhiraj.sharma0024@gmail.com>
References: <20200728175935.2130-1-dhiraj.sharma0024@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 23:29 +0530, Dhiraj Sharma wrote:
> I ran checkpatch.pl script which reported a warning to use const keyword
> on line 370.Therefore I made this change.

checkpatch is a brainless script.
Not everything it suggests is appropriate.

> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
[]
> @@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
> 
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;

This can't work.

Please make sure to compile your proposed changes
_before_ you post them.


