Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA099C2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A203320714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpeZdcqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgC3Vom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:44:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45862 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgC3Vom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:44:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id t4so1321266plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yn2EFFvNTosGdc1SZkzpeyxuiukyNodVGp9r67QGVU=;
        b=bpeZdcqBq24MKzJHBJE91pRfIBpXinPzKbrQ4GX/YeDTXKB01LSPLNTQOt7E44+W7t
         v8f90McdsutcJ0MlMmHLxq5e8zNWLybnDRxKZBFDQJGPKLQXRdBNu711ZTP5rl0ApKnD
         nw9VQICDfBeRA7PjxpZTY8/epVSXjmJ6RVtUWemr46HgbWNkO51tzFBuE+6U2bL1LdET
         Ohl1WtpVMT2z4ylntco43RBk3tFwmi4PZRDz55n9EJhcDvNNQGgIpsGkMhan7FExJuxK
         ObIDEQGEDS398qO9oGi21vrqJALJAuLDp4B7E6d1rinMCCG9SYAEDeMnpKZBxd7LxhIK
         Ro4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yn2EFFvNTosGdc1SZkzpeyxuiukyNodVGp9r67QGVU=;
        b=Q4yXkzL1muLs0ey6rXOealM5rw8mLOlXSCdCWIxgCWR7e2oSWb7vPA7LGuKa+XBU/3
         3Wz+bA8u/wZYJWLE+/Tii95Xf+KisedXJHwIgyvhS71uJ4bOifPsApk8dVHHqY1qZf+B
         fwNS/LF/+vgpQRaLttjHlpI5uddXpJpLpAJaR8HMIz5z/WO6UMmLb0Fxn4Z5lMkEhgPR
         yjLVU5SDfRGNWKr7MjHPFr4Hh0EqauTGaFb4qBoduP9JRY0/wabuGz1aOK44y5ZqtOsW
         X4x4WSmuIRy7pBiAl4fauucOYtmKuF3tiWRSVaW4kAc0E/2uLCV63qnuPVT76X01S6/n
         F88w==
X-Gm-Message-State: AGi0PuZU/X8pUQY3uB0lmwtjXfphAqX1cp52rz5z2H95/NKLHt4r/sdB
        S3xFAYPOhm2uOyVfFKf1BxQYM0LKn+gGdjX8ux6O4w==
X-Google-Smtp-Source: APiQypKcBWeA2a78qibOeBIj0+BRUPByPOL1BDH+JU/y0XMU/KhLdSEPtbLI8a7RZPS7k8ND7t77e5s/H8puzIRkEoU=
X-Received: by 2002:a17:90a:30c3:: with SMTP id h61mr203271pjb.18.1585604680507;
 Mon, 30 Mar 2020 14:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200325225911.131940-1-heidifahim@google.com>
In-Reply-To: <20200325225911.131940-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 30 Mar 2020 14:44:28 -0700
Message-ID: <CAFd5g45VWGgq=KOWAcM0cRKqrFg2=HhizZhX+0RsV5esWtJwaQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: convert test results to JSON
To:     Heidi Fahim <heidifahim@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 3:59 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Add a --json flag, which when specified when kunit_tool is run, calls
> method get_json_result.  This is a method within kunit_json.py that
> formats KUnit results into a dict conforming to the following KernelCI
> API test_group spec:
> https://api.kernelci.org/schema-test-group.html#post.  The user can
> specify a filename as the value to json in order to store the JSON
> results under linux/.
> Tested within kunit_tool_test.py in a new test case called
> KUnitJsonTest.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
