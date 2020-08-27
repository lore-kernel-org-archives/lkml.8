Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8668BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7E722B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lg/AH9AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgH0OyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgH0NOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:14:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D162C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:14:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x9so5075365wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/84K+kCuZ6/6lubgCBELCtdZ4/XE9uVpPslJepcM11E=;
        b=Lg/AH9AEhSUK+isMDgj7wH/mY7ANdDWwoM2RAo0z4gxnb6aSWwsvpON4v9iaEoRa+O
         Z9wd0bp41a0csDlRHs/2yTjdoMvi/P5Dn2U6SgGi26+dcGQFnYLlOap6sPQauFsROzbL
         lm8QkvJQhXdMU7cncWqQIxL4/0vpcCPO8ofTvqfFKYUV/32NX6ZgfVeFZyyWv39XFtUu
         m79mlcpJDhIddlRlUqbQSuYVzKbZnoc3HH9zeiHOk45L0PNzqPhBzMop82hNu+8+Mc78
         +NPhyT1/o3c9RZY83CGypUjgbcUtOBxDHAdmSUu5WUOF/RgA88UwrPnwDNFwWbf4ysmK
         UnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/84K+kCuZ6/6lubgCBELCtdZ4/XE9uVpPslJepcM11E=;
        b=HCRx5NjDB4cu0Bi9ugwBw4WqVf4lcC0OBX5uiPfH2frw+KQAY97h+cFYyI1Yo0tkK+
         ejAV4nPrmowAiJPur3YGLrjIYpwn5fKzt8MYl7YF0py295nKgnkYslyPlTSkKh+mPAq3
         F+JUBivg7q/1rgzNLq0P0u7DFJEZ+vH96dB68sheaVWvRXXcVaDI5sYevv+2t/Fh/gw5
         cxnLsh/FU0Elwiypmcb0LzJMFNCmQs5MDNIC5JJPW7PYNpXGtJYV7hpvBGuUMN4lJ5zs
         5Rv/vJuuMXVb1zw9JKSsHw66ghyATzl7wo1V0PJysBJSy1T2+mcL1lmagJABmehFRdKU
         y9Ew==
X-Gm-Message-State: AOAM530v8XImlW9zpvOkB1ido3/Vf+GrqQiorPbXIJYuBjdYVkSvdwNw
        L/jbiElqYhD1IUUmY/wsv0Us8g==
X-Google-Smtp-Source: ABdhPJzN9i8ZfDEBRslZvQ/bhX0aOKXV6A70ZxGYjAxbH8D/kgbxlur+s8QLGMJ46nypABJ6nrmuZA==
X-Received: by 2002:a1c:1d17:: with SMTP id d23mr11063997wmd.187.1598534084691;
        Thu, 27 Aug 2020 06:14:44 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id a8sm5844814wrh.86.2020.08.27.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 06:14:43 -0700 (PDT)
Date:   Thu, 27 Aug 2020 15:14:38 +0200
From:   Marco Elver <elver@google.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tim Bird <Tim.Bird@sony.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
Message-ID: <20200827131438.GA3597431@elver.google.com>
References: <20200702071416.1780522-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702071416.1780522-1-davidgow@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:14AM -0700, David Gow wrote:
> As discussed in [1], KUnit tests have hitherto not had a particularly
> consistent naming scheme. This adds documentation outlining how tests
> and test suites should be named, including how those names should be
> used in Kconfig entries and filenames.
> 
> [1]:
> https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
...
> +An example Kconfig entry:
> +
> +.. code-block:: none
> +
> +        config FOO_KUNIT_TEST
> +                tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
> +                depends on KUNIT
> +                default KUNIT_ALL_TESTS
> +                help
> +                    This builds unit tests for foo.
> +
> +                    For more information on KUnit and unit tests in general, please refer
> +                    to the KUnit documentation in Documentation/dev-tools/kunit
> +
> +                    If unsure, say N
> +
> +
> +Test Filenames
> +==============
> +
> +Where possible, test suites should be placed in a separate source file in the
> +same directory as the code being tested.
> +
> +This file should be named ``<suite>_kunit.c``. It may make sense to strip
> +excessive namespacing from the source filename (e.g., ``firmware_kunit.c`` instead of
> +``<drivername>_firmware.c``), but please ensure the module name does contain the
> +full suite name.

First of all, thanks for the talk yesterday! I only looked at this
because somebody pasted the LKML link. :-)

The example about excessive namespacing seems confusing. Was it supposed
to be 

	[...] firmware_kunit.c`` instead of ``<drivername>_firmware_kunit.c [...]

?


While I guess this ship has sailed, and *_kunit.c is the naming
convention now, I hope this is still just a recommendation and names of
the form *-test.c are not banned!

$> git grep 'KUNIT.*-test.o'
	drivers/base/power/Makefile:obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
	drivers/base/test/Makefile:obj-$(CONFIG_KUNIT_DRIVER_PE_TEST) += property-entry-test.o
	fs/ext4/Makefile:obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
	kernel/Makefile:obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
	lib/Makefile:obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
	lib/kunit/Makefile:obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
	lib/kunit/Makefile:obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
	lib/kunit/Makefile:obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o

$> git grep 'KUNIT.*_kunit.o'
# Returns nothing


Just an idea: Maybe the names are also an opportunity to distinguish
real _unit_ style tests and then the rarer integration-style tests. I
personally prefer using the more generic *-test.c, at least for the
integration-style tests I've been working on (KUnit is still incredibly
valuable for integration-style tests, because otherwise I'd have to roll
my own poor-man's version of KUnit, so thank you!). Using *_kunit.c for
such tests is unintuitive, because the word "unit" hints at "unit tests"
-- and having descriptive (and not misleading) filenames is still
important. So I hope you won't mind if *-test.c are still used where
appropriate.

Thanks,
-- Marco
