Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06B4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D28E2074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584138503;
	bh=HAfrWG3tnsOSw0BweDtQkVvI8TXB+u1VcKIlapo/b3U=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=fx1bS3g3yCliVSxUfC7jn6v17nOqeGfjeoFpbCRBRu6QWkNTqhPzCcicemUiwsdV9
	 v/m/emQePMhsp7SMz2sYkJBSFQVShViFL7j7nacP/0uij12B6r9j2A6v08VzCZ1P0J
	 ypdUjJMhPp+XYK8yOdpELCjJ5tJ8GN19LfzMC8JI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCMW2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 18:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgCMW2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:28:22 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 865902074B;
        Fri, 13 Mar 2020 22:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584138500;
        bh=HAfrWG3tnsOSw0BweDtQkVvI8TXB+u1VcKIlapo/b3U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SYmK9eoVfoNe9t7XmF4/gywii/xZgw1crX5njzaUdfwDQbvYNHzuklFsQN6I2W2IM
         Xz2N4n213C9CtRW5sT7jLb4Y+3DIbRph3tdW6EiCWLKygcCGqfGS42uh5xfv13D2d7
         P4BXDDLITitrLinUqPDf+oULDPg1ogyhp+d1Xebw=
Subject: Re: cross-compiling vm, confusion over output directory
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <MWHPR13MB0895E9C11DB4E72158445944FDFA0@MWHPR13MB0895.namprd13.prod.outlook.com>
From:   shuah <shuah@kernel.org>
Message-ID: <598c2cfe-debd-3f4c-532f-f78422118451@kernel.org>
Date:   Fri, 13 Mar 2020 16:28:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <MWHPR13MB0895E9C11DB4E72158445944FDFA0@MWHPR13MB0895.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

You are using an ancient email address for me.

Use either shuah@kernel.org or skhan@linuxfoundation.org

On 3/13/20 4:14 PM, Bird, Tim wrote:
> I was working on fixing the cross-compilation for the selftests/vm tests.
> Currently, there are two issues in my testing:
> 
> 1) problem: required library missing from some cross-compile environments:
> tools/testing/selftests/vm/mlock-random-test.c requires libcap
> be installed.  The target line for mlock-random-test in
> tools/testing/selftests/vm/Makefile looks like this:
> 
> $(OUTPUT)/mlock-random-test: LDLIBS += -lcap

You can use TEST_GEN_PROGS and define LDFLAGS for lcap

> 
> and mlock-random-test.c has this include line:
> #include <sys/capability.h>
> 
> this is confusing, since this is different from the header file
> linux/capability.h.  It is associated with the capability library (libcap)
> and not the kernel.  In any event, on some distros and in some
> cross-compile SDKs the package containing these files is not installed
> by default.
> 
> Once this library is installed, things progress farther.  Using an Ubuntu
> system, you can install the cross version of this library (for arm64) by doing:
> $ sudo apt install libcap-dev:arm64
> 
> 1) solution:
> I would like to add some meta-data about this build dependency, by putting
> something in the settings file as a hint to CI build systems.  Specifically, I'd like to
> create the file 'tools/testing/selftests/vm/settings', with the content:
> NEED_LIB=cap
> 
> We already use settings for other meta-data about a test (right now, just a
> non-default timeout value), but I don't want to create a new file or syntax
> for this build dependency data.
> 
> Let me know what you think.
> 
> I may follow up with some script in the kernel source tree to check these
> dependencies, independent of any CI system.  I have such a script in Fuego
> that I could submit, but it would need some work to fit into the kernel build
> flow for kselftest.  The goal would be to provide a nicely formatted warning,
> with a recommendation for a package install.  But that's more work than
> I think is needed right now just to let developers know there's a build dependency
> here.
> 
> 2) problem: reference to source-relative header file
> the Makefile for vm uses a relative path for include directories.
> Specifically, it has the line:
> CFLAGS = -Wall -I ../../../../../usr/include $(EXTRA_CFLAGS)
> 
> I believe this needs to reference kernel include files from the
> output directory, not the source directory.
> 
> With the relative include directory path, the program userfaultfd.c
> gets compilation error like this:
> 
> userfaultfd.c:267:21: error: 'UFFD_API_RANGE_IOCTLS_BASIC' undeclared here (not in a function)
>    .expected_ioctls = UFFD_API_RANGE_IOCTLS_BASIC,
>                       ^
> userfaultfd.c: In function 'uffd_poll_thread':
> userfaultfd.c:529:8: error: 'UFFD_EVENT_FORK' undeclared (first use in this function)
>     case UFFD_EVENT_FORK:
>          ^
> userfaultfd.c:529:8: note: each undeclared identifier is reported only once for each function it appears in
> userfaultfd.c:531:18: error: 'union <anonymous>' has no member named 'fork'
>      uffd = msg.arg.fork.ufd;
>                    ^
> 
> 2) incomplete solution:
> I originally changed this line to read:
> CFLAGS = -Wall -I $(KBUILD_OUTPUT)/usr/include $(EXTRA_CFLAGS)
> 

Take a look at seccomp patch I sent out. Use the approach used
in this patch.

https://lore.kernel.org/linux-kselftest/20200313212404.24552-1-skhan@linuxfoundation.org/T/#u

> This works when the output directory is specified using KBUILD_OUTPUT,
> but not when the output directory is specified using O=
> I'm not sure what happens when the output directory is specified
> with a non-source-tree current working directory.
> 
> In any event, while researching a proper solution to this, I found
> the following in tools/testing/selftests/Makefile:
> 
> If compiling with ifneq ($(O),)
>      BUILD := $(O)
> else
>      ifneq ($(KBUILD_OUTPUT),)
>          BUILD := $(KBUILD_OUTPUT)/kselftest
>      else
>          BUILD := $(shell pwd)
>          DEFAULT_INSTALL_HDR_PATH := 1
>      endif
> endif
> 
> This doesn't seem right.  It looks like the selftests Makefile treats a directory
> passed in using O= different from one specified using KBUILD_OUTPUT
> or the current working directory.
> In the KBUILD_OUTPUT case, you get an extra 'kselftest' directory layer
> that you don't get for the other two.

Are you using

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git 
kernelci branch

This is fixed and that is the very first patch I sent.

I also applied the patch to

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next 
branch

thanks,
-- Shuah
