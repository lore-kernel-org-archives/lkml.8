Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82359C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9E52072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipEG5zkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAQSgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:36:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40736 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:36:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so19077140lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version;
        bh=wr0L+fkYJFjsVYvkBdIzkFZMLbYhNm3OnWF1pjixm3I=;
        b=ipEG5zkUD3jRJDxuzQ/OOVDOUTp0/LUWaLDivdVOHZfcfnVYhQbKE0B10s7dIFV/B6
         iTJbiVCYsEhZAhypz6NkNnIGTic816IdDrH/sS+8teAXE+xC1H0FvggCWA6HA8AFSIIr
         iPJm5hx19cU1lNR+eiC6r1m1x0IokcROKy2JTucxwAlq9OZskV9+ZF67+9NROt63TfyE
         +qrORrGS4oudE4JgiQumvK4rPKCFcOlDfxXkXmqfYPWIzCiv71lFy+fCnfHgcw1hH0bt
         kPh17ifemzKOoPEyJbfPI0hUBxH29wJq/2+F3o1VQ/EIMEXK3OEKMYVCbq7UmecfybMF
         pJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version;
        bh=wr0L+fkYJFjsVYvkBdIzkFZMLbYhNm3OnWF1pjixm3I=;
        b=iUw0BHGR1dWCCTztdkRJ1SipDenKFsRCpXslJzXqUZyxA659Pl5L4X9BeV3RGL2E0p
         u/pkFOxZ7pj8fidAPEl+Guxz7e7iVpM1X2MY7ZdJXsvuUQlwBvK7QfJf3gU9xETY4wfu
         Bw6IDog1Uy/Z1TV0D5ufDfU3OKehXhKFJv8xkFGUF4ElPlLoTV2gTQYcU3Xs1NLQoTX3
         QOaXxETC9UsJ6pe8dnTVKvIusbZSauC+uArVL7XnMdYXsba/v40uS4FWdvoA1g1NSunZ
         BNtEiKlDGK9y0w8iEN9FFTgsK6MSDJ+RGEHb1zAdqw9uy2QxhyZWb8gtNeZChMY1pg7n
         I8SQ==
X-Gm-Message-State: APjAAAXFpI+veu+a5rjRbe2YjDGcMhjSWOJQLMl8EkRrappMxgXeoOR9
        ZuETgRJWlHeXRo7QrlqB3Lbi+zFx
X-Google-Smtp-Source: APXvYqw9/NYr8wiI1ZkYFIhktl7jNgpf21drtV5xUhbV4QWcsax6oZm0DONPR2FimDJkWItp0LCMlg==
X-Received: by 2002:ac2:53bb:: with SMTP id j27mr5895348lfh.39.1579286197003;
        Fri, 17 Jan 2020 10:36:37 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id i4sm12725750ljg.102.2020.01.17.10.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 10:36:36 -0800 (PST)
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] firmware_loader: load files from the mount namespace of init
Message-ID: <bb46ebae-4746-90d9-ec5b-fce4c9328c86@gmail.com>
Date:   Fri, 17 Jan 2020 20:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------299D982EB9ACEFC63BDD3988"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------299D982EB9ACEFC63BDD3988
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have an experimental setup where almost every possible system service 
(even early startup ones) runs in separate namespace, using a dedicated, 
minimal file system. In process of minimizing the contents of the file 
systems with regards to modules and firmware files, I noticed that in my 
system, the firmware files are loaded from three different mount 
namespaces, those of systemd-udevd, init and systemd-networkd. The logic 
of the source namespace is not very clear, it seems to depend on the 
driver, but the namespace of the current process is used.

So, this patch tries to make things a bit clearer and changes the 
loading of firmware files only from the mount namespace of init. This 
may also improve security, though I think that using firmware files as 
attack vector could be too impractical anyway.

Later, it might make sense to make the mount namespace configurable, for 
example with a new file in
/proc/sys/kernel/firmware_config/. That would allow a dedicated file 
system only for firmware files and those need not be present anywhere 
else. This configurability would make more sense if made also for kernel 
modules and /sbin/modprobe. Modules are already loaded from init 
namespace (usermodehelper uses kthreadd namespace) except when directly 
loaded by systemd-udevd.

-Topi

--------------299D982EB9ACEFC63BDD3988
Content-Type: text/x-diff;
 name="0001-firmware_loader-load-files-from-the-mount-namespace-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-firmware_loader-load-files-from-the-mount-namespace-.pa";
 filename*1="tch"

From 8adbf10d6b5a5e011b83fcf952e5dd4b4f2b749e Mon Sep 17 00:00:00 2001
From: Topi Miettinen <toiwoton@gmail.com>
Date: Fri, 17 Jan 2020 19:56:45 +0200
Subject: [PATCH] firmware_loader: load files from the mount namespace of init

Instead of using the mount namespace of the current process to load
firmware files, use the mount namespace of init process.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 drivers/base/firmware_loader/main.c |  6 ++++--
 fs/exec.c                           | 25 +++++++++++++++++++++++++
 include/linux/fs.h                  |  2 ++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 249add8c5e05..01f5315fae53 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -493,8 +493,10 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		}
 
 		fw_priv->size = 0;
-		rc = kernel_read_file_from_path(path, &buffer, &size,
-						msize, id);
+
+		/* load firmware files from the mount namespace of init */
+		rc = kernel_read_file_from_path_initns(path, &buffer,
+						       &size, msize, id);
 		if (rc) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
diff --git a/fs/exec.c b/fs/exec.c
index 74d88dab98dd..fda1364dc142 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -981,6 +981,31 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
+int kernel_read_file_from_path_initns(const char *path, void **buf,
+				      loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id)
+{
+	struct file *file;
+	struct path root;
+	int ret;
+
+	if (!path || !*path)
+		return -EINVAL;
+
+	task_lock(&init_task);
+	get_fs_root(init_task.fs, &root);
+	task_unlock(&init_task);
+
+	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
+	path_put(&root);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ret = kernel_read_file(file, buf, size, max_size, id);
+	fput(file);
+	return ret;
+}
+
 int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 			     enum kernel_read_file_id id)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..616a64871b2e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2994,6 +2994,8 @@ extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
 extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
+extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, loff_t,
+					     enum kernel_read_file_id);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
-- 
2.24.1


--------------299D982EB9ACEFC63BDD3988--
