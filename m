Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576BCC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D76222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfo0XMJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBMOay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:30:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32865 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMOay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:30:54 -0500
Received: by mail-qk1-f195.google.com with SMTP id h4so5863880qkm.0;
        Thu, 13 Feb 2020 06:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AJMQnCu2lnXXsd/VDcReV+jecWENLohGIrK0FThsNwc=;
        b=Kfo0XMJP6CvkR7yWIHIeUjWbv8wLay1Xiz3O/Dy1EJHlXsun4utPYDEsjAKOZ4Us9Z
         A0HU/tSirrPv+Y21FF+WupWgKbjye+9NS1WmDAU5P4RDam1Jb6Yc0I0hLjRxzg1CVqy/
         mDfPlpjojb8m0hSHiLkglA7btZzP+6m/64okYr9vGiVVfHuhZEKNzN20sxL/dPpKwTcU
         XH46nyY2RZzPdsBCghLFBwH4t/L57nuYIJNvaks1mCRLvyPJHpOZSn3F1XP9W6Awce7P
         36W4Ezc28eYzALP7Ah9yFEO+8timA0IArzXs1WWFyAbY9WVHHFeGm+/M80YEtykN1/AJ
         duHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AJMQnCu2lnXXsd/VDcReV+jecWENLohGIrK0FThsNwc=;
        b=r2rDuo32JsR0lvCAClsSMXiYEbuvKZwinRrZmaks7VaeAHpRt4dXvUVbpjwQ8/WGmR
         FU7WfoOdgWNpVWoc3gbo6Ib4xtTE4kYjsa9OUfrgLXZJYG17KEwh/cM/BNVEjgVmV1qt
         eqfnDsH7MLZWrxXSs0zQB9lGhXK0GRktD8vUrhg6QLr5yElTey1jI6ia76qiNFmNcID1
         naT979t1OaJofC4jAFCgHJ+jG9eSGqz22u8/fKpeaft5WsYnxE6+ad0gXDosW1rmA9AP
         9NwsiuChobS3gp+TK7Zs01IOK+oi1z75MXDA8b25abGdgcFgmUT4CJ4w9AWVD8C5qesR
         BrHQ==
X-Gm-Message-State: APjAAAUtCWl3Plh1z8eIU0VfbyGaDNU6r3ysHL4QM4u3e0hPcei3DiFA
        QDU1xTPyGleyc4H7y4MShM4=
X-Google-Smtp-Source: APXvYqxr+J0+VxSJ+iewYBVH+HuxQQSEJ5C+CaQLuOkvWK3U377urjUzueCKQeKOPsnghkMhVLEypw==
X-Received: by 2002:a05:620a:223:: with SMTP id u3mr6495218qkm.392.1581604252170;
        Thu, 13 Feb 2020 06:30:52 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 64sm1397139qkh.98.2020.02.13.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 06:30:51 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E3D94403AD; Thu, 13 Feb 2020 11:30:48 -0300 (-03)
Date:   Thu, 13 Feb 2020 11:30:48 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3] perf test: Fix test trace+probe_vfs_getname.sh
Message-ID: <20200213143048.GA22170@kernel.org>
References: <20200213122009.31810-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213122009.31810-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 13, 2020 at 01:20:09PM +0100, Thomas Richter escreveu:
> This test places a kprobe to function getname_flags() in the kernel
> which has the following prototype:
> 
>   struct filename *
>   getname_flags(const char __user *filename, int flags, int *empty)
> 
> Variable filename points to a filename located in user space memory.
> Looking at
> commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> the kprobe should indicate that user space memory is accessed.
> 
> The following patch specifies user space memory access first and if this
> fails use type 'string' in case 'ustring' is not supported.

What are you fixing?

I haven't seen any example of this test failing, and right now testing
it with:

[root@quaco ~]# uname -a
Linux quaco 5.6.0-rc1+ #1 SMP Wed Feb 12 15:42:16 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@quaco ~]#

Shows it is working:

[root@quaco ~]# perf test "trace + vfs"
72: Check open filename arg using perf trace + vfs_getname: Ok
[root@quaco ~]# perf test "trace + vfs"
72: Check open filename arg using perf trace + vfs_getname: Ok
[root@quaco ~]# perf test "trace + vfs"
72: Check open filename arg using perf trace + vfs_getname: Ok
[root@quaco ~]# perf test "trace + vfs"
72: Check open filename arg using perf trace + vfs_getname: Ok
[root@quaco ~]#

Making sure this is what is upstream _using_ that vfs_getname thing:

[root@quaco ~]# grep 'vfs_getname=g' ~acme/libexec/perf-core/tests/shell/lib/probe_vfs_getname.sh
		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
[root@quaco ~]#

Lets try the first line:

  # perf probe -l
  # perf probe 'vfs_getname=getname_flags:72 pathname=result->name:string'
  Added new event:
    probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)
  
  You can now use it in all perf tools, such as:
  
  	perf record -e probe:vfs_getname -aR sleep 1
  
  # perf probe -l
    probe:vfs_getname    (on getname_flags:72@acme/git/linux/fs/namei.c with pathname)
  #

Lets run it again using 'perf trace', that will see that
probe:vfs_getname in place and will use it:

[root@quaco ~]# perf trace -e open* perf test "trace + vfs" |& egrep '(trace\+probe_vf|touch|Ok)'
    30.496 ( 0.055 ms): perf/23673 openat(dfd: CWD, filename: /home/acme/libexec/perf-core/tests/shell/trace+probe_vfs_getname.sh) = 4
    31.621 ( 0.061 ms): perf/23673 openat(dfd: CWD, filename: /home/acme/libexec/perf-core/tests/shell/trace+probe_vfs_getname.sh) = 4
    38.807 ( 0.064 ms): trace+probe_vf/23675 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
    39.013 ( 0.063 ms): trace+probe_vf/23675 openat(dfd: CWD, filename: /lib64/libtinfo.so.6, flags: RDONLY|CLOEXEC) = 3
    39.253 ( 0.073 ms): trace+probe_vf/23675 openat(dfd: CWD, filename: /lib64/libdl.so.2, flags: RDONLY|CLOEXEC)  = 3
    39.477 ( 0.068 ms): trace+probe_vf/23675 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDONLY|CLOEXEC)   = 3
    40.177 ( 0.079 ms): trace+probe_vf/23675 openat(dfd: CWD, filename: /dev/tty, flags: RDWR|NONBLOCK)            = 3
    40.431 ( 0.067 ms): trace+probe_vf/23675 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: RDONLY|CLOEXEC) = 3
    40.661 ( 0.065 ms): trace+probe_vf/23675 openat(dfd: CWD, filename: /usr/lib64/gconv/gconv-modules.cache)      = 3
    42.236 ( 0.076 ms): trace+probe_vf/23675 openat(dfd: CWD, filename: /home/acme/libexec/perf-core/tests/shell/trace+probe_vfs_getname.sh) = 3
    46.023 ( 0.027 ms): trace+probe_vf/23675 openat(dfd: CWD, filename: /home/acme/libexec/perf-core/tests/shell/lib/probe.sh) = 3
   110.521 ( 0.023 ms): trace+probe_vf/23675 openat(dfd: CWD, filename: /home/acme/libexec/perf-core/tests/shell/lib/probe_vfs_getname.sh) = 3
  2040.036 ( 0.012 ms): trace+probe_vf/23898 openat(dfd: CWD, filename: ., flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 3
  2731.204 ( 0.017 ms): touch/23948 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
  2731.254 ( 0.017 ms): touch/23948 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDONLY|CLOEXEC)   = 3
  2731.668 ( 0.019 ms): touch/23948 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: RDONLY|CLOEXEC) = 3
  2731.765 ( 0.017 ms): touch/23948 openat(dfd: CWD, filename: /tmp/temporary_file.ipQ2W, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
  2732.089 ( 0.010 ms): perf/23917 openat(dfd: CWD, filename: /usr/bin/touch, flags: RDONLY|CLOEXEC)     = 6
 Ok
[root@quaco ~]# echo $?
0
[root@quaco ~]#

Then, I apply this patch and it starts consistently failing:

First clean up everything:

[root@quaco ~]# perf probe -d probe:*
Removed event: probe:vfs_getname
[root@quaco ~]# perf probe -l
[root@quaco ~]#

Then try again with this patch:

[acme@quaco perf]$ git cherry-pick d87c35073ec84736c08ef9a62bfed9cff1e5d9d5
[perf/urgent 8d9f3054a71c] perf test: Fix test trace+probe_vfs_getname.sh
 Author: Thomas Richter <tmricht@linux.ibm.com>
 Date: Thu Feb 13 13:20:09 2020 +0100
 1 file changed, 3 insertions(+), 1 deletion(-)
[acme@quaco perf]$

install it and check:

[root@quaco ~]# grep 'vfs_getname=g' ~acme/libexec/perf-core/tests/shell/lib/probe_vfs_getname.sh
		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:string" || \
		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
[root@quaco ~]#

Then run the test:

[root@quaco ~]# perf test "trace + vfs"
72: Check open filename arg using perf trace + vfs_getname: FAILED!
[root@quaco ~]# perf test "trace + vfs"
72: Check open filename arg using perf trace + vfs_getname: FAILED!
[root@quaco ~]# perf test "trace + vfs"
72: Check open filename arg using perf trace + vfs_getname: FAILED!
[root@quaco ~]# perf test "trace + vfs"
72: Check open filename arg using perf trace + vfs_getname: FAILED!
[root@quaco ~]#
[root@quaco ~]#
[root@quaco ~]# for a in $(seq 5) ; do perf test "trace + vfs" ; done
72: Check open filename arg using perf trace + vfs_getname: FAILED!
72: Check open filename arg using perf trace + vfs_getname: FAILED!
72: Check open filename arg using perf trace + vfs_getname: FAILED!
72: Check open filename arg using perf trace + vfs_getname: FAILED!
72: Check open filename arg using perf trace + vfs_getname: FAILED!
[root@quaco ~]#

Now lets try putting in place the probes as you did, using "ustring":

[root@quaco ~]# perf probe -l
[root@quaco ~]# perf probe "vfs_getname=getname_flags:72 pathname=result->uptr:ustring"
Added new event:
  probe:vfs_getname    (on getname_flags:72 with pathname=result->uptr:ustring)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

[root@quaco ~]#

[root@quaco ~]# perf trace -e open* perf test "trace + vfs" |& egrep '(trace\+probe_vf|touch|Ok|FAIL)'
     7.658 ( 0.003 ms): perf/19334 openat(dfd: CWD, filename: ts/shell/trace+probe_vfs_getname.sh)       = 4
     7.787 ( 0.004 ms): perf/19334 openat(dfd: CWD, filename: ts/shell/trace+probe_vfs_getname.sh)       = 72: Check open filename arg using perf trace + vfs_getname:4
    10.242 ( 0.004 ms): trace+probe_vf/19336 openat(dfd: CWD, filename: /etc/ld.so.preload, flags: RDONLY|CLOEXEC) = 3
    10.259 ( 0.005 ms): trace+probe_vf/19336 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
    10.295 ( 0.006 ms): trace+probe_vf/19336 openat(dfd: CWD, filename: /lib64/libtinfo.so.6, flags: RDONLY|CLOEXEC) = 3
    10.334 ( 0.006 ms): trace+probe_vf/19336 openat(dfd: CWD, filename: /lib64/libdl.so.2, flags: RDONLY|CLOEXEC)  = 3
    10.546 ( 0.008 ms): trace+probe_vf/19336 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDWR|NONBLOCK)    = 3
    10.596 ( 0.005 ms): trace+probe_vf/19336 openat(dfd: CWD, filename: /dev/tty, flags: RDONLY|CLOEXEC)           = 3
    10.627 ( 0.005 ms): trace+probe_vf/19336 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive)            = 3
    11.070 ( 0.007 ms): trace+probe_vf/19336 openat(dfd: CWD, filename: OLDPWD)                                    = 3
    12.076 ( 0.008 ms): trace+probe_vf/19336 openat(dfd: CWD, filename: )                                          = 3
    30.957 ( 0.012 ms): trace+probe_vf/19336 openat(dfd: CWD, filename: )                                          = 3
   471.042 ( 0.010 ms): trace+probe_vf/19541 openat(dfd: CWD, filename: 	, flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 3
   789.676 ( 0.007 ms): touch/19627 openat(dfd: CWD, filename: /etc/ld.so.preload, flags: RDONLY|CLOEXEC) = 3
   789.700 ( 0.008 ms): touch/19627 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
   789.820 ( 0.004 ms): perf/19610 openat(dfd: CWD, filename: /usr/bin/touch, flags: RDONLY|CLOEXEC)     = 6
   789.936 ( 0.011 ms): touch/19627 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDONLY|CLOEXEC)   = 3
   790.002 ( 0.125 ms): touch/19627 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
 FAILED!
[root@quaco ~]#
[root@quaco ~]# perf trace -e open* perf test "trace + vfs" |& egrep '(trace\+probe_vf|touch|Ok|FAIL)'
    27.182 ( 0.047 ms): perf/23632 openat(dfd: CWD, filename: ts/shell/trace+probe_vfs_getname.sh)       = 4
    28.189 ( 0.049 ms): perf/23632 openat(dfd: CWD, filename: ts/shell/trace+probe_vfs_getname.sh)       = 4
    35.281 ( 0.062 ms): trace+probe_vf/23634 openat(dfd: CWD, filename: /etc/ld.so.preload, flags: RDONLY|CLOEXEC) = 3
    35.488 ( 0.060 ms): trace+probe_vf/23634 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
    35.707 ( 0.070 ms): trace+probe_vf/23634 openat(dfd: CWD, filename: /lib64/libtinfo.so.6, flags: RDONLY|CLOEXEC) = 3
    35.921 ( 0.069 ms): trace+probe_vf/23634 openat(dfd: CWD, filename: /lib64/libdl.so.2, flags: RDONLY|CLOEXEC)  = 3
    36.634 ( 0.082 ms): trace+probe_vf/23634 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDWR|NONBLOCK)    = 3
    36.895 ( 0.063 ms): trace+probe_vf/23634 openat(dfd: CWD, filename: /dev/tty, flags: RDONLY|CLOEXEC)           = 3
    37.113 ( 0.058 ms): trace+probe_vf/23634 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive)            = 3
    38.738 ( 0.071 ms): trace+probe_vf/23634 openat(dfd: CWD, filename: OLDPWD)                                    = 3
    42.446 ( 0.025 ms): trace+probe_vf/23634 openat(dfd: CWD, filename: 	)                                         = 3
   105.135 ( 0.024 ms): trace+probe_vf/23634 openat(dfd: CWD, filename: 	)                                         = 3
  2027.596 ( 0.012 ms): trace+probe_vf/23815 openat(dfd: CWD, filename: 	, flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 3
  2302.961 ( 0.138 ms): perf/23824 openat(dfd: CWD, filename: /lib/modules/5.6.0-rc1+/kernel/drivers/usb/storage/ums-onetouch.ko, flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 8
  2661.047 ( 0.008 ms): perf/23824 openat(dfd: CWD, filename: /usr/bin/touch, flags: RDONLY|CLOEXEC)     = 6
  2661.940 (         ): touch/23885 openat(dfd: CWD, filename: , flags: RDONLY|CLOEXEC)                ...
  2661.940 ( 0.326 ms): touch/23885  ... [continued]: openat())                                           = 3
  2662.386 ( 0.075 ms): touch/23885 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
  2662.940 ( 0.099 ms): touch/23885 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDONLY|CLOEXEC)   = 3
  2663.185 ( 0.076 ms): touch/23885 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
 FAILED!
[root@quaco ~]#

If we use it directly:

[root@quaco ~]# perf trace -e probe:vfs_getname sleep 1
     0.000 sleep/30276 probe:vfs_getname(__probe_ip: -1942877253, pathname: "")
     1.107 sleep/30276 probe:vfs_getname(__probe_ip: -1942877253, pathname: "")
     1.186 sleep/30276 probe:vfs_getname(__probe_ip: -1942877253, pathname: "/etc/ld.so.cache")
     1.589 sleep/30276 probe:vfs_getname(__probe_ip: -1942877253, pathname: "/lib64/libc.so.6")
[root@quaco ~]# perf trace -e probe:vfs_getname sleep 1
     0.000 sleep/30782 probe:vfs_getname(__probe_ip: -1942877253, pathname: "")
     0.016 sleep/30782 probe:vfs_getname(__probe_ip: -1942877253, pathname: "/etc/ld.so.preload")
     0.048 sleep/30782 probe:vfs_getname(__probe_ip: -1942877253, pathname: "/etc/ld.so.cache")
     0.405 sleep/30782 probe:vfs_getname(__probe_ip: -1942877253, pathname: "/lib64/libc.so.6")
[root@quaco ~]# perf trace -e probe:vfs_getname sleep 1
     0.000 sleep/31237 probe:vfs_getname(__probe_ip: -1942877253, pathname: "")
     0.016 sleep/31237 probe:vfs_getname(__probe_ip: -1942877253, pathname: "/etc/ld.so.preload")
     0.049 sleep/31237 probe:vfs_getname(__probe_ip: -1942877253, pathname: "/etc/ld.so.cache")
     0.376 sleep/31237 probe:vfs_getname(__probe_ip: -1942877253, pathname: "/lib64/libc.so.6")
[root@quaco ~]#

While:

[root@quaco ~]# strace -e open,openat,access sleep 1
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
+++ exited with 0 +++
[root@quaco ~]# strace -e open,openat,access sleep 1
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
+++ exited with 0 +++
[root@quaco ~]# strace -e open,openat,access sleep 1
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
+++ exited with 0 +++
[root@quaco ~]#

Also for completeness:

[root@quaco ~]# strace -f -e open,openat perf test "trace + vfs" |& egrep '(vfs_getname\.sh|trace\+probe_vf|touch|Ok|FAILED)'
openat(AT_FDCWD, "/home/acme/libexec/perf-core/tests/shell/record+script_probe_vfs_getname.sh", O_RDONLY) = 4
openat(AT_FDCWD, "/home/acme/libexec/perf-core/tests/shell/probe_vfs_getname.sh", O_RDONLY) = 4
openat(AT_FDCWD, "/home/acme/libexec/perf-core/tests/shell/trace+probe_vfs_getname.sh", O_RDONLY) = 4
openat(AT_FDCWD, "/home/acme/libexec/perf-core/tests/shell/record+script_probe_vfs_getname.sh", O_RDONLY) = 4
openat(AT_FDCWD, "/home/acme/libexec/perf-core/tests/shell/probe_vfs_getname.sh", O_RDONLY) = 4
openat(AT_FDCWD, "/home/acme/libexec/perf-core/tests/shell/trace+probe_vfs_getname.sh", O_RDONLY) = 4
[pid  7538] openat(AT_FDCWD, "/home/acme/libexec/perf-core/tests/shell/trace+probe_vfs_getname.sh", O_RDONLY) = 3
[pid  7538] openat(AT_FDCWD, "/home/acme/libexec/perf-core/tests/shell/lib/probe_vfs_getname.sh", O_RDONLY) = 3
[pid  7768] openat(AT_FDCWD, "/usr/bin/touch", O_RDONLY|O_CLOEXEC) = 6
 FAILED!
[root@quaco ~]# grep 'vfs_getname=g' /home/acme/libexec/perf-core/tests/shell/lib/probe_vfs_getname.sh
		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:string" || \
		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
[root@quaco ~]#

[root@quaco ~]# cat /sys/kernel/debug/tracing/README  | grep -B6 -A5 ustring
   place (uprobe): <path>:<offset>[(ref_ctr_offset)]
	     args: <name>=fetcharg[:type]
	 fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],
	           $stack<index>, $stack, $retval, $comm, $arg<N>,
	           +|-[u]<offset>(<fetcharg>), \imm-value, \"imm-string"
	     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,
	           b<bit-width>@<bit-offset>/<container-size>, ustring,
	           <type>\[<array-size>\]
	    field: <stype> <name>;
	    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,
	           [unsigned] char/int/long
  events/		- Directory containing all trace event subsystems:
[root@quaco ~]#

So this needs some more investigation :-\

I'm not applying this patch till we get to the bottom of this, ok?

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 7cb99b433888..30c1eadbc5be 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -13,7 +13,9 @@ add_probe_vfs_getname() {
>  	local verbose=$1
>  	if [ $had_vfs_getname -eq 1 ] ; then
>  		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
> -		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:string" || \
>  		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
>  	fi
>  }
> -- 
> 2.21.0
> 

-- 

- Arnaldo
