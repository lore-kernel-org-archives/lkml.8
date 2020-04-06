Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6A3C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351C5238E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCDK7E1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgDFOH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:07:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44589 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:07:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so16162347qkc.11;
        Mon, 06 Apr 2020 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hN2xuaWsyNjCaRF45tyR+htCYnhC3ctmM5qosC2W1ic=;
        b=CCDK7E1RL7p0En992jjqkCglKva7goplCRdB4BdqVNaIVfEgl3bX4XS8/gNqjuWu0f
         jET/osdhjj42ToJ6aX+zhoj3Mne/yOvRj2FktxYl9lvgdVYPa1G6gjZcvCbEwc7FcvC0
         YXd/Nrov5r3h+T47LE9L8WO5/bj96aw+YvCO1lMVy6gcINApjwb5u044MhLs9GnIrJ3N
         /h4v0XmX3Jl1tBhfM/CANqfGO6xQFAO/qxTSbOBbdnv8bZoMjGepEzD6gk1OmzdwGo74
         N6PQ2avCvE3wf7N713A4WiZ9Mkpqt+8DUICUKZ7cb4+SWkRpGbWcKntJok/RvBpVgG5M
         QBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hN2xuaWsyNjCaRF45tyR+htCYnhC3ctmM5qosC2W1ic=;
        b=DcpJOOKBgejPQK//+Fd9TjFbfMbEKyLtNU9VkpstQMQLcQ8bUMaXMCdqdnwr9+gfDz
         eH2wzrXsaGUKq/eQAhcZXdMR607YrXAW46Jg/4GVD4Cp3bHhwCP37UKtw/cd6PyPH95h
         Vxh5duZj4Jwj1hHU8jB1CuzFGkGHJK+3ivmF+DZjAHEw9JANxSe1lZgh2QkhluiZK+zV
         my2A7DTCkh6HeseWvDOUpqb4Q40auDR+berc4o7Bg6/aWIxmPajJGKPG5SLTZcxoIRFW
         qLmGypbZoSR3eSO/g6tsGplVgSET35s4TlqBoaTzdu3IU270TwTIfPNSFcCWgxzSSKyG
         LY1A==
X-Gm-Message-State: AGi0PuaSGI2WUfMpbY6j8SvkWpcvY9WrrwJiq+U0pHQZq3OYiIUjWUXe
        zi50OV+l9E+K58GET4piII8=
X-Google-Smtp-Source: APiQypIMgXkLRmmCyWPPftDbEDqk0uI4xOgR9pUBKnuzhHgs47m9J+4V4PG9OUtfzbVWOcRkp14oAQ==
X-Received: by 2002:a05:620a:1019:: with SMTP id z25mr21823801qkj.479.1586182043992;
        Mon, 06 Apr 2020 07:07:23 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x24sm2472202qth.80.2020.04.06.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:07:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B73C409A3; Mon,  6 Apr 2020 11:07:21 -0300 (-03)
Date:   Mon, 6 Apr 2020 11:07:21 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 2/5] tools api fs: make xxx__mountpoint() more scalable
Message-ID: <20200406140721.GD29826@kernel.org>
References: <20200402154357.107873-1-irogers@google.com>
 <20200402154357.107873-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402154357.107873-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 02, 2020 at 08:43:54AM -0700, Ian Rogers escreveu:
> From: Stephane Eranian <eranian@google.com>
> 
> The xxx_mountpoint() interface provided by fs.c finds
> mount points for common pseudo filesystems. The first
> time xxx_mountpoint() is invoked, it scans the mount
> table (/proc/mounts) looking for a match. If found, it
> is cached. The price to scan /proc/mounts is paid once
> if the mount is found.
> 
> When the mount point is not found, subsequent calls to
> xxx_mountpoint() scan /proc/mounts over and over again.
> There is no caching.

Thanks, applied, lets see if someone screams...

- Arnaldo
 
> This causes a scaling issue in perf record with hugeltbfs__mountpoint().
> The function is called for each process found in synthesize__mmap_events().
> If the machine has thousands of processes and if the /proc/mounts has many
> entries this could cause major overhead in perf record. We have observed
> multi-second slowdowns on some configurations.
> 
> As an example on a laptop:
> 
> Before:
> $ sudo umount /dev/hugepages
> $ strace -e trace=openat -o /tmp/tt perf record -a ls
> $ fgrep mounts /tmp/tt
> 285
> 
> After:
> $ sudo umount /dev/hugepages
> $ strace -e trace=openat -o /tmp/tt perf record -a ls
> $ fgrep mounts /tmp/tt
> 1
> 
> One could argue that the non-caching in case the moint point is not found
> is intentional. That way subsequent calls may discover a moint point if
> the sysadmin mounts the filesystem. But the same argument could be made
> against caching the mount point. It could be unmounted causing errors.
> It all depends on the intent of the interface. This patch assumes it
> is expected to scan /proc/mounts once. The patch documents the caching
> behavior in the fs.h header file.
> 
> An alternative would be to just fix perf record. But it would solve
> the problem with hugetlbs__mountpoint() but there could be similar
> issues (possibly down the line) with other xxx_mountpoint() calls
> in perf or other tools.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/fs/fs.c | 17 +++++++++++++++++
>  tools/lib/api/fs/fs.h | 12 ++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
> index 027b18f7ed8c..82f53d81a7a7 100644
> --- a/tools/lib/api/fs/fs.c
> +++ b/tools/lib/api/fs/fs.c
> @@ -90,6 +90,7 @@ struct fs {
>  	const char * const	*mounts;
>  	char			 path[PATH_MAX];
>  	bool			 found;
> +	bool			 checked;
>  	long			 magic;
>  };
>  
> @@ -111,31 +112,37 @@ static struct fs fs__entries[] = {
>  		.name	= "sysfs",
>  		.mounts	= sysfs__fs_known_mountpoints,
>  		.magic	= SYSFS_MAGIC,
> +		.checked = false,
>  	},
>  	[FS__PROCFS] = {
>  		.name	= "proc",
>  		.mounts	= procfs__known_mountpoints,
>  		.magic	= PROC_SUPER_MAGIC,
> +		.checked = false,
>  	},
>  	[FS__DEBUGFS] = {
>  		.name	= "debugfs",
>  		.mounts	= debugfs__known_mountpoints,
>  		.magic	= DEBUGFS_MAGIC,
> +		.checked = false,
>  	},
>  	[FS__TRACEFS] = {
>  		.name	= "tracefs",
>  		.mounts	= tracefs__known_mountpoints,
>  		.magic	= TRACEFS_MAGIC,
> +		.checked = false,
>  	},
>  	[FS__HUGETLBFS] = {
>  		.name	= "hugetlbfs",
>  		.mounts = hugetlbfs__known_mountpoints,
>  		.magic	= HUGETLBFS_MAGIC,
> +		.checked = false,
>  	},
>  	[FS__BPF_FS] = {
>  		.name	= "bpf",
>  		.mounts = bpf_fs__known_mountpoints,
>  		.magic	= BPF_FS_MAGIC,
> +		.checked = false,
>  	},
>  };
>  
> @@ -158,6 +165,7 @@ static bool fs__read_mounts(struct fs *fs)
>  	}
>  
>  	fclose(fp);
> +	fs->checked = true;
>  	return fs->found = found;
>  }
>  
> @@ -220,6 +228,7 @@ static bool fs__env_override(struct fs *fs)
>  		return false;
>  
>  	fs->found = true;
> +	fs->checked = true;
>  	strncpy(fs->path, override_path, sizeof(fs->path) - 1);
>  	fs->path[sizeof(fs->path) - 1] = '\0';
>  	return true;
> @@ -246,6 +255,14 @@ static const char *fs__mountpoint(int idx)
>  	if (fs->found)
>  		return (const char *)fs->path;
>  
> +	/* the mount point was already checked for the mount point
> +	 * but and did not exist, so return NULL to avoid scanning again.
> +	 * This makes the found and not found paths cost equivalent
> +	 * in case of multiple calls.
> +	 */
> +	if (fs->checked)
> +		return NULL;
> +
>  	return fs__get_mountpoint(fs);
>  }
>  
> diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
> index 936edb95e1f3..aa222ca30311 100644
> --- a/tools/lib/api/fs/fs.h
> +++ b/tools/lib/api/fs/fs.h
> @@ -18,6 +18,18 @@
>  	const char *name##__mount(void);	\
>  	bool name##__configured(void);		\
>  
> +/*
> + * The xxxx__mountpoint() entry points find the first match mount point for each
> + * filesystems listed below, where xxxx is the filesystem type.
> + *
> + * The interface is as follows:
> + *
> + * - If a mount point is found on first call, it is cached and used for all
> + *   subsequent calls.
> + *
> + * - If a mount point is not found, NULL is returned on first call and all
> + *   subsequent calls.
> + */
>  FS(sysfs)
>  FS(procfs)
>  FS(debugfs)
> -- 
> 2.26.0.rc2.310.g2932bb562d-goog
> 

-- 

- Arnaldo
