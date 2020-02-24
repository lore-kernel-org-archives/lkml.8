Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC7CC35669
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE60F2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBCVXUj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBXD3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:29:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38475 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgBXD3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:29:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so3469935plj.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 19:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K0JW2EfFhuCbUtNkMo3m3FY0j1WPwSQhES6P2P+ACdw=;
        b=vBCVXUj4Pgidp3lXYVnC7n+3XRqhCoUXuj+3Uiqouorh0riEdjxWV17kshwmp8fkOR
         zUOBgK7+2al1nxKWGr4NHPQlfaAdITZLKAAfi0koYPp/EPCuIYkDU8yKcFEf5HL5vvpu
         kmiyamt0Dfu3IstcTTZM+hVR0ZjKvyzuNTCZdYJGC1M6zR9t55Oph2TjJGfdxY2x92HF
         KrDXeaNKYYQdA5GbeLSYido7K555QXO5V2WPYQ3KkT2m36xS1GQ0ORbJPjeQztYyzwzx
         tPyDC5EHAvLh+aVsmthNgYTlNIu20vxW96GzHAzY30ysA6RuETjmF+XaX0ASmBXjiSYW
         B12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K0JW2EfFhuCbUtNkMo3m3FY0j1WPwSQhES6P2P+ACdw=;
        b=lnae+TQAeQZUwa8g0bd1WN2Dn2eH8of9gqJanyc02Fz4uThIbzmcMnx0xEbtWFcl41
         IQ4P44XSnbR9NESJviaaRGgJve8CmxTQT2FJX3+RQ+ybzTpl5by561dFjjzl/i1jeWtJ
         AMGNDagRwGBAm97jbcBIDYPcBYRKXScZi4HKvc41t0JHMWP+96xqU2WZetNZWlgDddQn
         j0XXKIodQAGP8QZVwQ2he+DoVizJNS7JuQdG1hkaov6wS6R3coxHxTPdHiJgl1JVRt27
         yfA3irdkF7bI/TCsrrUnWNvYXl37n+TqtJT1rt0U1BHH+V49lT0ZQvQtgjtXUkevo/I6
         gmIQ==
X-Gm-Message-State: APjAAAV0r8kq9LRyZT3COM5H68rQxCXOQtRBWgpUFEE/+ZefOVagC6OM
        jNzuKDEGKgZJXgOMHGpIh7lA5w==
X-Google-Smtp-Source: APXvYqztxRjiovsa78Cv3oB8wD+gtm1MQM6nFAf7AeO8HF1kElzb/LH7H2rVLKYsJDh9HXcKRSrv5A==
X-Received: by 2002:a17:902:103:: with SMTP id 3mr48206826plb.34.1582514941893;
        Sun, 23 Feb 2020 19:29:01 -0800 (PST)
Received: from google.com ([2401:fa00:fc:1:28b:9f23:d296:c845])
        by smtp.gmail.com with ESMTPSA id r7sm10870261pfg.34.2020.02.23.19.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 19:29:01 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:28:54 +0800
From:   Martin Liu <liumartin@google.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>, minchan@kernel.org,
        surenb@google.com, wvw@google.com, hridya@google.com
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        liumartin@google.com, jenhaochen@google.com
Subject: Re: [PATCH] dma-buf: use spinlock to protect set/get name operation
Message-ID: <20200224032854.GA215090@google.com>
References: <20200114150658.205302-1-liumartin@google.com>
 <CAO_48GEbH+JM6247KUc+XeD2xAcMsMmfNHXd1R7sLkkWPgfX7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO_48GEbH+JM6247KUc+XeD2xAcMsMmfNHXd1R7sLkkWPgfX7Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 12:05:53PM +0530, Sumit Semwal wrote:
> Hello Martin,
> 
> Thanks for your patches - they look decent.
> 
> May I please request you to run get_maintainers.pl (the patches need
> to be sent to a couple of other MLs too for wider review).
> 
> Best,
> Sumit.
Sorry for the late reply. Sure, I will include more MLs for wider
review. Thanks for the suggestion.

> On Tue, 14 Jan 2020 at 20:37, Martin Liu <liumartin@google.com> wrote:
> >
> > We introduced setname ioctl in commit bb2bb9030425 ("dma-buf:
> > add DMA_BUF_SET_NAME ioctls") that provides userpsace
> > to attach a free-form name for tracking and counting shared
> > buffers. However the d_dname callback could be called in atomic
> > context. This call path comes from selinux that verifies all
> > inherited open files from exec call. To verify all inherited
> > open files, kernel would iterate all fds which need to hold
> > spin_lock to get denty name by calling d_dname operation.
> > In dma-buf d_dname callback, we use mutex lock to prevent the
> > race from setname causing this issue.
> >
> > This commit adds a spinlock to protect set/get name operation
> > to fix this issue.
> >
> > [  165.617090] Call trace:
> > [  165.620504]  ___might_sleep+0x114/0x118
> > [  165.625344]  __might_sleep+0x50/0x84
> > [  165.629928]  __mutex_lock_common+0x5c/0x10b0
> > [  165.635215]  mutex_lock_nested+0x40/0x50
> > [  165.640157]  dmabuffs_dname+0x48/0xdc
> > [  165.644821]  d_path+0x78/0x1e4
> > [  165.648870]  audit_log_d_path+0x68/0x134
> > [  165.653807]  common_lsm_audit+0x33c/0x6f4
> > [  165.658832]  slow_avc_audit+0xb4/0xf0
> > [  165.663503]  avc_has_perm+0xdc/0x1a4
> > [  165.668081]  file_has_perm+0x70/0x154
> > [  165.672750]  match_file+0x54/0x6c
> > [  165.677064]  iterate_fd+0x74/0xac
> > [  165.681369]  selinux_bprm_committing_creds+0xfc/0x210
> > [  165.687459]  security_bprm_committing_creds+0x2c/0x40
> > [  165.693546]  install_exec_creds+0x1c/0x68
> > [  165.698569]  load_elf_binary+0x3a0/0x13c8
> > [  165.703590]  search_binary_handler+0xb8/0x1e4
> > [  165.708964]  __do_execve_file+0x6e4/0x9c8
> > [  165.713984]  __arm64_sys_execve+0x44/0x54
> > [  165.719008]  el0_svc_common+0xa8/0x168
> > [  165.723765]  el0_svc_handler+0x78/0x94
> > [  165.728522]  el0_svc+0x8/0xc
> >
> > Signed-off-by: Martin Liu <liumartin@google.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 11 +++++++----
> >  include/linux/dma-buf.h   |  2 ++
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index ce41cd9b758a..7cbcb22ad0e4 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -45,10 +45,10 @@ static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
> >         size_t ret = 0;
> >
> >         dmabuf = dentry->d_fsdata;
> > -       dma_resv_lock(dmabuf->resv, NULL);
> > +       spin_lock(&dmabuf->name_lock);
> >         if (dmabuf->name)
> >                 ret = strlcpy(name, dmabuf->name, DMA_BUF_NAME_LEN);
> > -       dma_resv_unlock(dmabuf->resv);
> > +       spin_unlock(&dmabuf->name_lock);
> >
> >         return dynamic_dname(dentry, buffer, buflen, "/%s:%s",
> >                              dentry->d_name.name, ret > 0 ? name : "");
> > @@ -335,6 +335,7 @@ static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
> >                 return PTR_ERR(name);
> >
> >         dma_resv_lock(dmabuf->resv, NULL);
> > +       spin_lock(&dmabuf->name_lock);
> >         if (!list_empty(&dmabuf->attachments)) {
> >                 ret = -EBUSY;
> >                 kfree(name);
> > @@ -344,6 +345,7 @@ static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
> >         dmabuf->name = name;
> >
> >  out_unlock:
> > +       spin_unlock(&dmabuf->name_lock);
> >         dma_resv_unlock(dmabuf->resv);
> >         return ret;
> >  }
> > @@ -403,10 +405,10 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
> >         /* Don't count the temporary reference taken inside procfs seq_show */
> >         seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
> >         seq_printf(m, "exp_name:\t%s\n", dmabuf->exp_name);
> > -       dma_resv_lock(dmabuf->resv, NULL);
> > +       spin_lock(&dmabuf->name_lock);
> >         if (dmabuf->name)
> >                 seq_printf(m, "name:\t%s\n", dmabuf->name);
> > -       dma_resv_unlock(dmabuf->resv);
> > +       spin_unlock(&dmabuf->name_lock);
> >  }
> >
> >  static const struct file_operations dma_buf_fops = {
> > @@ -561,6 +563,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
> >         dmabuf->file = file;
> >
> >         mutex_init(&dmabuf->lock);
> > +       spin_lock_init(&dmabuf->name_lock);
> >         INIT_LIST_HEAD(&dmabuf->attachments);
> >
> >         mutex_lock(&db_list.lock);
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index af73f835c51c..1b138580f746 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -292,6 +292,7 @@ struct dma_buf_ops {
> >   * @exp_name: name of the exporter; useful for debugging.
> >   * @name: userspace-provided name; useful for accounting and debugging,
> >   *        protected by @resv.
> > + * @name_lock: lock to protect name.
> >   * @owner: pointer to exporter module; used for refcounting when exporter is a
> >   *         kernel module.
> >   * @list_node: node for dma_buf accounting and debugging.
> > @@ -320,6 +321,7 @@ struct dma_buf {
> >         void *vmap_ptr;
> >         const char *exp_name;
> >         const char *name;
> > +       spinlock_t name_lock;
> >         struct module *owner;
> >         struct list_head list_node;
> >         void *priv;
> > --
> > 2.25.0.rc1.283.g88dfdc4193-goog
> >
> 
> 
> -- 
> Thanks and regards,
> 
> Sumit Semwal
> Linaro Consumer Group - Kernel Team Lead
> Linaro.org │ Open source software for ARM SoCs
