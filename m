Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5609AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D0720748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586291246;
	bh=LbQjDxMEbtoLVYXFNvCCWp3cSEsuIalbXceF8YbEtxA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=XOmFOe7TPD45Unw6eC8gK/hHAnLnHYZCSx6+LNQjpVXoappORNC20XkcSdHpwHonb
	 5hp9QqWcIVNahK7K/oGo/SIJi0sjs4L3WfO8rgS9wnm3Fenx7xXbfkdmcZ8RGBVGtf
	 WsDmlqZemGTM6I2av0CMuzS2r0XVfgkgzqxR1Amg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgDGU1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:27:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35974 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGU1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:27:24 -0400
Received: by mail-io1-f66.google.com with SMTP id n10so4836133iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SVvr6g7i1p/M9GSwOcps1JS+QJ+c+tYawXf8HxS6FAg=;
        b=ERmZoJGm3MROmoDbARyL7yFfNKGkv1UfIaNu9oXaxze+apSwpdJbX+MtTqKKJzOaWD
         iLQE+mLK4Rtg5ZB3nMuu6jKIqv6CKJrIEKRZWP04xO24LuAdhqzqC297f8NAwwSHJ4ek
         TxRA3I6RZgIvTPX3Szfv6OOt7+rN9tgTjwDCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVvr6g7i1p/M9GSwOcps1JS+QJ+c+tYawXf8HxS6FAg=;
        b=njnqOlQzHBiud534DwWWvSPzehqznqrO+d3nU+0VNA4f1ZitH4oFpMwROdjvivm47N
         qQgfTumRKrHtAz+OzUXoF+EL9RpSNGCIWPz1gh37wjUVmKNKkUZGbNv6E8ihdheVSVUX
         9G6QwdMUvpgdh34izQG3QKrr+dTlS/8lLwmVF3AorDEmk31Q0ETtXS/qG09P2+952Loa
         gQ9ZC7si/XUpKVcC4MBGz85oeWr3SgkG9Z314p0q86F9jK/+8mbukei1WIpojWgoiwBz
         1WaBhCVgHpUwQUV1D93qhSEZeX5a71EEuzDA2TaZ0lXr3gvQgGjBL87kNIis26o3nMlb
         WDLQ==
X-Gm-Message-State: AGi0PuaN6cnC9JtIVDa5BnlENSnUCGIz9X37FB5CLLQ7wxjleA7/shmL
        5iOSutfUloWV1QV5qELo+Fgehpaz+ZM=
X-Google-Smtp-Source: APiQypIuRQK9ZP9+jgyaTkcIMsrf5M463W5wJjE2qMEq/FH446fLo3g6BGbrEhHfi1J7w/h1IgWGHQ==
X-Received: by 2002:a05:6602:2e8e:: with SMTP id m14mr3829889iow.25.1586291243579;
        Tue, 07 Apr 2020 13:27:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d70sm7405916ill.57.2020.04.07.13.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:27:23 -0700 (PDT)
Subject: Re: [selftests] d3fd949abd: kernel-selftests.memfd.fuse_mnt.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernelnorg>, linux-kernel@vger.kernel.org,
        lkp@lists.01.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200404132613.GN8179@shao2-debian>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <63d3b756-69eb-c9ee-a833-598733ca7609@linuxfoundation.org>
Date:   Tue, 7 Apr 2020 14:27:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200404132613.GN8179@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/20 7:26 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: d3fd949abd3e3005dab7ccb185c3c8bc0ad639f1 ("selftests: Fix memfd to support relocatable build (O=objdir)")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: kernel-selftests
> with following parameters:
> 
> 	group: kselftests-02
> 	ucode: 0xd6
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> # selftests: memfd: memfd_test
> # memfd: CREATE
> # memfd: BASIC
> # memfd: SEAL-WRITE
> # memfd: SEAL-FUTURE-WRITE
> # memfd: CREATE
> # memfd: BASIC
> # memfd: SEAL-WRITE
> # memfd: SEAL-FUTURE-WRITE
> # memfd: SEAL-SHRINK
> # memfd: SEAL-GROW
> # memfd: SEAL-RESIZE
> # memfd: SHARE-DUP
> # memfd: SHARE-MMAP
> # memfd: SHARE-OPEN
> # memfd: SHARE-FORK
> # memfd: SHARE-DUP (shared file-table)
> # memfd: SHARE-MMAP (shared file-table)
> # memfd: SHARE-OPEN (shared file-table)
> # memfd: SHARE-FORK (shared file-table)
> # memfd: DONE
> ok 1 selftests: memfd: memfd_test


> # selftests: memfd: fuse_test
> # Aborted
> not ok 2 selftests: memfd: fuse_test # exit=134
> # selftests: memfd: fuse_mnt
> # fuse: missing mountpoint parameter
> not ok 3 selftests: memfd: fuse_mnt # exit=1

Thanks for the reporting the problem. I will get a fix in soon.
It isn't indication of a problem. This commit caused regression
resulting in running tests without creating mnt point first.

The above failure are a result of that.

> # selftests: memfd: run_fuse_test.sh
> # opening: ./mnt/memfd
> # fuse: DONE
> ok 4 selftests: memfd: run_fuse_test.sh
> 

thanks,
-- Shuah
