Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01012C433EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C1A204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20150623.gappssmtp.com header.i=@batbytes-com.20150623.gappssmtp.com header.b="LQW8kDGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbgEMPAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389244AbgEMPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:00:41 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25701C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:00:41 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id b71so9378709ilg.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=+rPg11J9VlvVDeV8znfbO+l0Zmgl15XOXAgw8ZhUwkI=;
        b=LQW8kDGiT9n4vRSn4+zIJqiC+H9EC4J5xm++TGKc4H95qo+Bwx5zxGUUlg/0Yw1ZLa
         qaFof47jhHBozx1Ekv6eJ2M4l8S/rGIEuiX22F65CF13dqXSfnSiK5JbLipu5IlG5JPh
         SkTNr4IGQDc8p0QrsPgLIUUw9drXJDaXtwdwjSFV2cCWqIdyRyXLK8DXEcZ+r1eImUaY
         rkUDzKHQ88TXrpK+U0t/t5EstVRHh6JJgnJI9MJ5ZZobKAny09T+TVCaU5XBcQHqylnV
         0jyrMlcUVfIviPLPmLC9oIc5JfuxSrzif7/xbPSIgweiZdVGrKJAc4mes/oiF7qQsPRF
         Uhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+rPg11J9VlvVDeV8znfbO+l0Zmgl15XOXAgw8ZhUwkI=;
        b=V9egPToF0H59yNiYq3hi7B1LXONxbpotJa1WOkUa191kCTurHlV+VRbaUu6EFSj3cb
         74MOQDLg5rhGU8J0kaCyvuVPGVA6svcceDVFQp3vP+9HhevIZnCWRl9tb9SicG2zQurU
         2DpIX2bMT2hS98MeWG36NfY9a9Hr/euxUgd9nQftmPCVo0JO8AjWTZnxflLuupAueCbN
         JxBygaCSLzIgYJHFAo6/gn7n4gdrnMUaBiTn2ufh9A+3as5SGXdnvfMu+K5jlKotn0cL
         11qaHpq0JeInwvZBrP4pzdkf09dq77TdoNCP7Dzm+A+m83+SITVBvU6a6/AxomTr09LH
         8dFw==
X-Gm-Message-State: AGi0Puba3Ly/Eow3FJFryS6P5X1wY8cSco99/VogzVBF3DOz54zPbhqM
        ANq0HzfzjjS4MIb4NwWfcRyjKaTk0QxQ0Jz9OtZR5SJ7okM=
X-Google-Smtp-Source: APiQypLBR/G4xZV9sFHLT56RfUzH/+GXiuKifvTb4r+7q/Sdj1l0SvIoEeSNXGtIoeRf0XtqGCJdWSrOvYD/talPO2g=
X-Received: by 2002:a05:6e02:f81:: with SMTP id v1mr16264384ilo.246.1589382040025;
 Wed, 13 May 2020 08:00:40 -0700 (PDT)
MIME-Version: 1.0
From:   Patrick Donnelly <batrick@batbytes.com>
Date:   Wed, 13 May 2020 08:00:28 -0700
Message-ID: <CACh33FpkBrHpTNfZN6EiyaVPVb6bvJqHO8dJkiHzWPOF0+pKAQ@mail.gmail.com>
Subject: file system permissions regression affecting root
To:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newer kernels (at least 5.6), it appears root is not able to write
to files owned by other users in a sticky directory:

$ uname -r
5.6.11-arch1-1
$ stat -f /tmp
  File: "/tmp"
    ID: 0        Namelen: 255     Type: tmpfs
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 2005160    Free: 2005092    Available: 2005092
Inodes: Total: 2005160    Free: 2005112
$ stat /tmp
  File: /tmp
  Size: 440             Blocks: 0          IO Block: 4096   directory
Device: 2fh/47d Inode: 21533       Links: 20
Access: (1777/drwxrwxrwt)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-05-11 11:50:52.780667565 -0700
Modify: 2020-05-13 07:40:19.617941285 -0700
Change: 2020-05-13 07:40:19.617941285 -0700
 Birth: -
$ touch /tmp/foo
$ stat /tmp/foo
  File: /tmp/foo
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 2fh/47d Inode: 3441684     Links: 1
Access: (0640/-rw-r-----)  Uid: ( 1000/pdonnell)   Gid: (  985/   users)
Access: 2020-05-13 07:40:29.218026785 -0700
Modify: 2020-05-13 07:40:29.218026785 -0700
Change: 2020-05-13 07:40:29.218026785 -0700
 Birth: -
$ sudo /bin/sh -c 'echo 1 > /tmp/foo'
/bin/sh: /tmp/foo: Permission denied
$ sudo strace -f -- /bin/sh -c 'echo 1 > /tmp/foo' |& grep foo
execve("/bin/sh", ["/bin/sh", "-c", "echo 1 > /tmp/foo"],
0x7fff92dec300 /* 15 vars */) = 0
openat(AT_FDCWD, "/tmp/foo", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1
EACCES (Permission denied)
write(2, "/bin/sh: /tmp/foo: Permission de"..., 37/bin/sh: /tmp/foo:
Permission denied


Compare to Linux 4.18:

$ uname -r
4.18.0-147.3.1.el8_1.x86_64
$ stat /dev/shm
  File: /dev/shm
  Size: 100             Blocks: 0          IO Block: 4096   directory
Device: 16h/22d Inode: 15466       Links: 2
Access: (1777/drwxrwxrwt)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:tmpfs_t:s0
Access: 2020-05-12 17:37:07.029131257 +0000
Modify: 2020-05-13 14:35:44.161036943 +0000
Change: 2020-05-13 14:35:44.161036943 +0000
 Birth: -
$ stat -f /dev/shm
  File: "/dev/shm"
    ID: 0        Namelen: 255     Type: tmpfs
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 9243647    Free: 9243604    Available: 9243604
Inodes: Total: 9243647    Free: 9243643
$ touch /dev/shm/foo
$ stat /dev/shm/foo
  File: /dev/shm/foo
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 16h/22d Inode: 5616861     Links: 1
Access: (0640/-rw-r-----)  Uid: ( 1156/pdonnell)   Gid: ( 1156/pdonnell)
Context: unconfined_u:object_r:user_tmp_t:s0
Access: 2020-05-13 14:44:55.121908033 +0000
Modify: 2020-05-13 14:44:55.121908033 +0000
Change: 2020-05-13 14:44:55.121908033 +0000
 Birth: -
$ sudo -- /bin/sh -c 'echo 1 > /dev/shm/foo'
$

This seems to be related to the directory being owned by root; it does
not happen when the directory is owned by the user:

$ uname -r
5.6.11-arch1-1
$ sudo chown pdonnell:users gtmp
$ stat gtmp
  File: gtmp
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: fe04h/65028d    Inode: 2819062     Links: 2
Access: (1777/drwxrwxrwt)  Uid: ( 1000/pdonnell)   Gid: (  985/   users)
Access: 2020-05-13 07:47:06.344892575 -0700
Modify: 2020-05-13 07:50:24.709987998 -0700
Change: 2020-05-13 07:52:52.137963637 -0700
 Birth: 2020-05-13 07:34:09.937974845 -0700
$ stat -f gtmp
  File: "gtmp"
    ID: f24a3528a175df48 Namelen: 255     Type: ext2/ext3
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 36495867   Free: 8991668    Available: 7120360
Inodes: Total: 9338880    Free: 8147228
$ touch gtmp/foo
$ stat gtmp/foo
  File: gtmp/foo
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: fe04h/65028d    Inode: 2754033     Links: 1
Access: (0640/-rw-r-----)  Uid: ( 1000/pdonnell)   Gid: (  985/   users)
Access: 2020-05-13 07:53:10.218124141 -0700
Modify: 2020-05-13 07:53:10.218124141 -0700
Change: 2020-05-13 07:53:10.218124141 -0700
 Birth: 2020-05-13 07:53:10.218124141 -0700
$ sudo strace -f -- /bin/sh -c 'echo 1 > gtmp/foo' |& grep foo
execve("/bin/sh", ["/bin/sh", "-c", "echo 1 > gtmp/foo"],
0x7ffe03362430 /* 15 vars */) = 0
openat(AT_FDCWD, "gtmp/foo", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
$ rm gtmp/foo
$ sudo chown root:root gtmp
$ touch gtmp/foo
# stat gtmp/foo
  File: gtmp/foo
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: fe04h/65028d    Inode: 2754033     Links: 1
Access: (0640/-rw-r-----)  Uid: ( 1000/pdonnell)   Gid: (  985/   users)
Access: 2020-05-13 07:55:18.892599600 -0700
Modify: 2020-05-13 07:55:18.892599600 -0700
Change: 2020-05-13 07:55:18.892599600 -0700
 Birth: 2020-05-13 07:55:18.892599600 -0700
$ sudo strace -f -- /bin/sh -c 'echo 1 > gtmp/foo' |& grep foo
execve("/bin/sh", ["/bin/sh", "-c", "echo 1 > gtmp/foo"],
0x7fff588732f0 /* 15 vars */) = 0
openat(AT_FDCWD, "gtmp/foo", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1
EACCES (Permission denied)
write(2, "/bin/sh: gtmp/foo: Permission de"..., 37/bin/sh: gtmp/foo:
Permission denied


-- 
Patrick Donnelly
