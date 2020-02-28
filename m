Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408A7C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1935B246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582860633;
	bh=BWlDwlEUuY8N6oCQ2u90XkUxBuJmR3UNJmvOXpQ30Nc=;
	h=From:Subject:To:Cc:Date:List-ID:From;
	b=j9eYMLgQC5jhsP1uHmnMy0URU2podkEh8OIMVICJ/eGH/S9s1uSLkU+EVYMS/5M6U
	 FyjrJ271I1CcH54V8wXA+6kzug1Dl3IliMBJcVfp4+JbJ0WonPQB+qb+UFXXgv9Cqr
	 sEBkqdsf4LKiMAWW9bfXWCOGMDTU4GqTVgG3Vh4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgB1Dab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:30:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40073 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbgB1Dab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:30:31 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so1921130iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 19:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=N2BqVG9jx759fspM1MT4M/EZFAbzaNvfYYtJ27AebE4=;
        b=N2SMZK75zttYmtEci9QhvN9q0T3gR8N1y2DXBkP/FAfwpMtO/qP0D3ol0K302v2fUu
         yYKz66WG+tqPtRD1YXIihCXjM7C/OmUbJeV+fKDZW0I2ee1I3wlFuD1eA0Lt5akLCjNv
         BZct/jGS0PIoSVO+53rAqD7EAR0WnJoJfj7D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=N2BqVG9jx759fspM1MT4M/EZFAbzaNvfYYtJ27AebE4=;
        b=tQvS9C9JUMQOQwlDP/w0wz6NLHPVruwp8uCro4uKzDatTwLHFox9MO3reY2VXXafjw
         8JdWnxPs5NdTQeFtiP0tFQm+I+CO1NE0W0j1usuAbjjNmty95crpl7qkeFPA7NnJ7wOe
         qpnn0r8D23nSDXsg5xwEZsQV0ck89bvInPk0L4HoUtVS/r0UPmwJgfd1YaUy//UBgFMR
         ZjY3UQmWGPE0c/FHHUx84Tbn6dCM/xFNVYWAOwaEttXLG9+UHhfo7KcgzpvrIZ2Mw53E
         9LsIuqmV4gQUA8caEgEDGOAS8tj7JgIpha9OSqp/dz00WeU8dSu/REro5pY4RzKfsTBc
         ajfQ==
X-Gm-Message-State: APjAAAXgkk+cJx0TpO0QAUAIAh8lhbLMzD40alTfKcTIAWVmihfXqPyW
        OI4u91MSqEZQ6dExii0JZz+lQQ==
X-Google-Smtp-Source: APXvYqxFjEjYwzRJo+N7QAQV/FfJizpn+0hpd4pUy3fw28ntwGYm6O9O1lan6t5XdxvvnlCfMGS8mA==
X-Received: by 2002:a6b:4e13:: with SMTP id c19mr1974583iob.58.1582860630607;
        Thu, 27 Feb 2020 19:30:30 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l2sm2614532ilo.6.2020.02.27.19.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 19:30:29 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [ANN] Kselftest integration into Kernel CI
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <3b3dc707-7ae7-955b-69fe-b9abe9ae26c5@linuxfoundation.org>
Date:   Thu, 27 Feb 2020 20:30:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrating Kselftest into Kernel CI rings depends on Kselftest build
and install framework to support Kernel CI use-cases. I am kicking off
an effort to support Kselftest runs in Kernel CI rings. Running these
tests in Kernel CI rings will help quality of kernel releases, both
stable and mainline.

What is required for full support?

1. Cross-compilation & relocatable build support
2. Generates objects in objdir/kselftest without cluttering main objdir
3. Leave source directory clean
4. Installs correctly in objdir/kselftest/kselftest_install and adds
    itself to run_kselftest.sh script generated during install.

Note that install step is necessary for all files to be installed for
run time support.

I looked into the current status and identified problems. The work is
minimal to add full support. Out of 80+ tests, 7 fail to cross-build
and 1 fails to install correctly.

List is below:

Tests fails to build: bpf, capabilities, kvm, memfd, mqueue, timens, vm
Tests fail to install: android (partial failure)
Leaves source directory dirty: bpf, seccomp

I have patches ready for the following issues:

Kselftest objects (test dirs) clutter top level object directory.
seccomp_bpf generates objects in the source directory.

I created a topic branch to collect all the patches:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kernelci

I am going to start working on build problems. If anybody is
interested in helping me with this effort, don't hesitate to
contact me. I first priority is fixing build and install and
then look into tests that leave the source directory dirty.

Detailed report can be found here:

https://drive.google.com/file/d/11nnWOKIzzOrE4EiucZBn423lzSU_eNNv/view?usp=sharing

thanks,
-- Shuah
