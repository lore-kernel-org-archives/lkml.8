Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D11D206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkiZJ1re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgFKP2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:28:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51489 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728544AbgFKP17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591889278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=wbu2ps1HBP/gNBExG0xAYjVeINdIIBZXPhB2Vr5oEqc=;
        b=gkiZJ1reeZHcMCU4IVFAY3QyvcxkwLvx1xsf7OfBR0YrGiR9Lt+ue0bOy3bdcqj6Bi4dcJ
        ssGpy7qL22y9H7QgjBN9iDqkdKbOdSiYmR0hjXWKxKSWPVso+nGDXVqUxzuUmj6liDgMBX
        AOdyOKXLv0XPrDC9+cThvuedh4fuqwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-UPnSLkwJPsm-Sl57q8eq9Q-1; Thu, 11 Jun 2020 11:27:54 -0400
X-MC-Unique: UPnSLkwJPsm-Sl57q8eq9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 864711845174;
        Thu, 11 Jun 2020 15:27:53 +0000 (UTC)
Received: from redhat.com (ovpn-112-163.phx2.redhat.com [10.3.112.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4458460BF3;
        Thu, 11 Jun 2020 15:27:53 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.93)
        (envelope-from <fche@redhat.com>)
        id 1jjP7P-0001RO-Jf; Thu, 11 Jun 2020 11:27:51 -0400
Date:   Thu, 11 Jun 2020 11:27:51 -0400
From:   "Frank Ch. Eigler" <fche@redhat.com>
To:     systemtap@sourceware.org, linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: systemtap 4.3 release
Message-ID: <20200611152751.GA5527@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SystemTap team announces release 4.3

Enhancements to this release include: Userspace probes may be targeted
by buildid as an alternate to a path name, script functions may use
probe $context variables, stapbpf improvements including try-catch
statements, and error probes.

= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-4.3 (commit c9c23c987d)

  There have been over 120.31415 commits since the last release.
  There have been 27+ bugs fixed / features added since the last release.

= SystemTap frontend (stap) changes

- The target of process probes may be specified by hexadecimal buildid
  as an alternative to a path name.  This makes it possible to probe a
  variety of versions or aliases of a program, even if they are
  running inside containers under a different path name.  Works best
  with a debuginfod server that publishes the executables / debuginfo.
  The following probes glibc.so 2.32-2.fc32.x86_64 from fedora running
  anywhere on your machine.
  # export DEBUGINFOD_URLS=https://debuginfod.elfutils.org/
  # stap -e 'probe process("7ca24d4dc3de9d62d9ad6bb25e5b70a3e57a342f")
                   .function("*system") { log("hi") }'

- Functions can now be context-sensitive, meaning that they may make
  references to $context variables and similar constructs that could
  formerly appear only inside probe handlers.  This is implemented by
  cloning such functions for each probe.  
  Only some probe point (dwarf-based user & kernel) types are supported.
  function foo () { println ($$vars) }
  probe kernel.function("do_exit") { foo() }
  probe process("/bin/ls").function("main") { foo() }
  probe process("/lib*/libc.so.6").mark("*") { foo() }

- The process(EXE).begin probe handlers are now always triggered for
  already-running target processes.

= SystemTap backend changes

- Almost all of the kmalloc() allocations exceeding 4KB have been
  replaced by vmalloc(). This helps stap's kernel runtime work
  properly on systems with serious fragmentation in physical memory
  address space.

- More $variable resolution errors may be generated, especially for
  @var("") constructs that target global variables.  These are
  duplicate-eliminated by default, but may be seen with verbosity>=2.

- The stapbpf backend now supports try-catch statements, an improved
  error tapset, and error probes.

- The "Build-id mismatch" condition now becomes a warning, so while
  related probes are not inserted, the rest of the script may run.

= SystemTap tapset changes

- Added a new tapset function dump_stack() which prints the current
  kernel backtrace to the kernel trace buffer (as a thin wrapper
  around the kernel C API function dump_stack).

- The proc_mem_rss() tapset function now includes the resident shared
  memory pages as expected. The old behavior can be restored by the
  --compatible=4.2 option on the command line.

- Modules compiled with guru mode for a particular kernel version can
  now only be loaded on kernels with exactly matching version
  (vermagic string) instead of any kernel whose API matches according
  to the modversions mechanism. Use -B CONFIG_MODVERSIONS=y to restore
  the prior behaviour.

= SystemTap sample scripts

- All 180+ examples can be found at https://sourceware.org/systemtap/examples/

- New sample scripts:
  security-band-aids/cve-2018-1000001.stp        
  security-band-aids/cve-2018-6485
  Historical emergency security band-aid scripts for example purposes only

= Examples of tested kernel versions 

2.6.32 (RHEL6 x86_64)
3.10.0 (RHEL7 x86_64)
4.15.0 (Ubuntu 18.04 x86_64)
4.18.0 (RHEL8 x86_64, aarch64, ppc64le, s390x)
5.3.8  (Fedora 30 i686)
5.3.9  (Fedora 31 x86_64)
5.4.0  (Fedora 32 x86_64)
5.7.0  (Fedora 33 x86_64) 

= Known issues with this release

- A change to syscall wrappers has resulted in the loss of the ability
  to modify syscall parameters.  (PR26015)

- An sdt probe cannot parse a parameter that uses a segment register.
  (PR13429)

- The presence of a line such as
      *CFLAGS += $(call cc-option, -fno-var-tracking-assignments)
  in the linux kernel Makefile unnecessarily reduces debuginfo quality,
  consider removing that line if you build kernels.

= Contributors for this release

Aaron Merey, Alice Zhang*, Craig Ringer*, Frank Ch. Eigler, Frank
Sorenson*, HATAYAMA Daisuke*, Juri Lelli*, Sagar Patel, Serhei Makarov,
Siddhesh Poyarekar, William Cohen, Yichun Zhang (agentzh)

Special thanks to new contributors, marked with '*' above.

= Bugs fixed for this release <https://sourceware.org/PR#####>

6834 stap-client should not use bash network redirections
10280 allow relaxing of `uname -r` matching runtime assertion ro ABI-compatible kernel series
11249 uprobes fails on glibc get-pc-thunk call insn probe
11277 _stp_text_str uses bad octal escapes
11599 Support data pointer in tracepoint callbacks
12609 Cannot see variable values in partial inlined functions with gcc 4.6
12970 populate runtime/bad-addr database
13793 IPv6 nfs_proc.stp tapset changes needed
13896 use darkserver for downloading debuginfo
15016 kernel 3.7.2xen uprobes can cause SEGV on probed app
15774 Userspace syscall.return probes do not support $arg variables
16131 CONFIG_USER_NS support
18001 Using sysname(), caller(), or callers(n) causes a gcc internal error
20394 inconsistency in exe/library paths searching between @cast() and process.library.function probes
22182 On rawhide, we're getting lots of 'suspicious RCU usage' kernel warnings
22265 on rawhide, we're getting a kernel panic
22315 bpf: error handling / try-catch? / error() function
23276 suspicious RCU usage' on rawhide 4.18.0-0.rc0
23634 WARNING: Can't parse SDT_V3 operand for x86_64 qemu tapset probe points
24954 stapdyn on ppc/aarch64 do not support full register set
25186 Vim ftplugin creates conflicting autocmd group
25265 stapscripts using ustack, ubacktrace etc fail to compile on kernel 5.3
25290 process(EXE).begin may occasionally miss already-running target processes from EXE
25298 unused blocks may cause segmentation fault
25568 buildid-based process probes
25579 detect kernel lockdown/secureboot in effect
25686 user_buffer_quoted incorrectly octal-escapes non-printable characters
25841 probe-context features for functions
26074 adapt to unexported kallsyms_lookup_name
26099 adapt to new struct proc_ops in procfs_create_data      
26109 bug when begin probe exits quickly

