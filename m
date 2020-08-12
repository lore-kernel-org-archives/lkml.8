Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9760EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 23:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2298C206A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 23:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHLXxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 19:53:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:34114 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgHLXxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 19:53:13 -0400
IronPort-SDR: LgKb86Ogm/oODv+UTKeK7s+jLizT0TESLtT5pOUac24yD+8GWvUifcU1naDLG02kNIwGI8erFg
 LVC79Hk5sU6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="141951882"
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="141951882"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 16:53:09 -0700
IronPort-SDR: SVA0/rbNeYzVci0M9or+XfFKZZac3l8Tv4hbyCsFjdl9UmIN/kUQSLl5YKodsmWvVzgnvSIKFg
 AEsxb3PIjcfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="308885066"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2020 16:53:07 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k60YM-0000Jb-VW; Wed, 12 Aug 2020 23:53:06 +0000
Date:   Thu, 13 Aug 2020 07:52:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikos Tsironis <ntsironis@arrikto.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>
Subject: drivers/md/dm-clone-metadata.c:781:4: warning: Variable 'r' is
 reassigned a value before the old one has been used.
Message-ID: <202008130719.om3R9Zgj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7c2a69f610e64c8dec6a06a66e721f4ce1dd783a
commit: 7431b7835f554f8608b415a02cf3c3f086309e02 dm: add clone target
date:   11 months ago
compiler: sparc-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> fs/gfs2/xattr.c:884:9: warning: Identical condition 'error', second condition is always false [identicalConditionAfterEarlyExit]
    return error;
           ^
   fs/gfs2/xattr.c:867:6: note: first condition
    if (error)
        ^
   fs/gfs2/xattr.c:884:9: note: second condition
    return error;
           ^
   fs/gfs2/xattr.c:1103:9: warning: Identical condition 'error', second condition is always false [identicalConditionAfterEarlyExit]
    return error;
           ^
   fs/gfs2/xattr.c:1081:6: note: first condition
    if (error)
        ^
   fs/gfs2/xattr.c:1103:9: note: second condition
    return error;
           ^
>> fs/gfs2/xattr.c:543:8: warning: Variable 'error' is reassigned a value before the old one has been used. [redundantAssignment]
    error = gfs2_ea_get_copy(ip, &el, data, len);
          ^
   fs/gfs2/xattr.c:539:8: note: Variable 'error' is reassigned a value before the old one has been used.
    error = -ENOMEM;
          ^
   fs/gfs2/xattr.c:543:8: note: Variable 'error' is reassigned a value before the old one has been used.
    error = gfs2_ea_get_copy(ip, &el, data, len);
          ^
>> fs/minix/namei.c:159:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = minix_delete_entry(de, page);
        ^
   fs/minix/namei.c:150:0: note: Variable 'err' is reassigned a value before the old one has been used.
    int err = -ENOENT;
   ^
   fs/minix/namei.c:159:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = minix_delete_entry(de, page);
        ^
   fs/minix/namei.c:214:7: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
     err = -ENOTEMPTY;
         ^
   fs/minix/namei.c:194:0: note: Variable 'err' is reassigned a value before the old one has been used.
    int err = -ENOENT;
   ^
   fs/minix/namei.c:214:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = -ENOTEMPTY;
         ^
   fs/minix/namei.c:214:7: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
     err = -ENOTEMPTY;
         ^
   fs/minix/namei.c:204:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = -EIO;
         ^
   fs/minix/namei.c:214:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = -ENOTEMPTY;
         ^
   fs/minix/namei.c:218:7: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
     err = -ENOENT;
         ^
   fs/minix/namei.c:214:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = -ENOTEMPTY;
         ^
   fs/minix/namei.c:218:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = -ENOENT;
         ^
--
>> fs/jffs2/wbuf.c:934:9: warning: Uninitialized variable: ret [uninitvar]
    return ret;
           ^
   fs/jffs2/wbuf.c:653:10: warning: Uninitialized variable: ret [uninitvar]
     return ret;
            ^
>> fs/minix/inode.c:286:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = -ENOMEM;
        ^
   fs/minix/inode.c:162:0: note: Variable 'ret' is reassigned a value before the old one has been used.
    int ret = -EINVAL;
   ^
   fs/minix/inode.c:286:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -ENOMEM;
        ^
>> fs/minix/dir.c:99:34: warning: Variable 'offset' is reassigned a value before the old one has been used. [redundantAssignment]
    for ( ; n < npages; n++, offset = 0) {
                                    ^
   fs/minix/dir.c:96:9: note: Variable 'offset' is reassigned a value before the old one has been used.
    offset = pos & ~PAGE_MASK;
           ^
   fs/minix/dir.c:99:34: note: Variable 'offset' is reassigned a value before the old one has been used.
    for ( ; n < npages; n++, offset = 0) {
                                    ^
>> fs/gfs2/main.c:146:8: warning: Variable 'error' is reassigned a value before the old one has been used. [redundantAssignment]
    error = register_shrinker(&gfs2_qd_shrinker);
          ^
   fs/gfs2/main.c:97:8: note: Variable 'error' is reassigned a value before the old one has been used.
    error = -ENOMEM;
          ^
   fs/gfs2/main.c:146:8: note: Variable 'error' is reassigned a value before the old one has been used.
    error = register_shrinker(&gfs2_qd_shrinker);
          ^
--
>> fs/qnx6/dir.c:127:42: warning: Variable 'start' is reassigned a value before the old one has been used. [redundantAssignment]
    for ( ; !done && n < npages; n++, start = 0) {
                                            ^
   fs/qnx6/dir.c:120:0: note: Variable 'start' is reassigned a value before the old one has been used.
    unsigned start = (pos & ~PAGE_MASK) / QNX6_DIR_ENTRY_SIZE;
   ^
   fs/qnx6/dir.c:127:42: note: Variable 'start' is reassigned a value before the old one has been used.
    for ( ; !done && n < npages; n++, start = 0) {
                                            ^
--
>> fs/sysv/balloc.c:128:12: warning: Local variable count shadows outer variable [shadowVar]
     unsigned count;
              ^
   fs/sysv/balloc.c:106:11: note: Shadowed declaration
    unsigned count;
             ^
   fs/sysv/balloc.c:128:12: note: Shadow variable
     unsigned count;
              ^
--
>> fs/sysv/dir.c:80:34: warning: Variable 'offset' is reassigned a value before the old one has been used. [redundantAssignment]
    for ( ; n < npages; n++, offset = 0) {
                                    ^
   fs/sysv/dir.c:77:9: note: Variable 'offset' is reassigned a value before the old one has been used.
    offset = pos & ~PAGE_MASK;
           ^
   fs/sysv/dir.c:80:34: note: Variable 'offset' is reassigned a value before the old one has been used.
    for ( ; n < npages; n++, offset = 0) {
                                    ^
>> fs/sysv/namei.c:79:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = PTR_ERR(inode);
        ^
   fs/sysv/namei.c:71:0: note: Variable 'err' is reassigned a value before the old one has been used.
    int err = -ENAMETOOLONG;
   ^
   fs/sysv/namei.c:79:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = PTR_ERR(inode);
        ^
   fs/sysv/namei.c:84:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = page_symlink(inode, symname, l);
        ^
   fs/sysv/namei.c:79:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = PTR_ERR(inode);
        ^
   fs/sysv/namei.c:84:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = page_symlink(inode, symname, l);
        ^
   fs/sysv/namei.c:127:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = sysv_make_empty(inode, dir);
        ^
   fs/sysv/namei.c:119:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = PTR_ERR(inode);
        ^
   fs/sysv/namei.c:127:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = sysv_make_empty(inode, dir);
        ^
   fs/sysv/namei.c:159:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = sysv_delete_entry (de, page);
        ^
   fs/sysv/namei.c:153:0: note: Variable 'err' is reassigned a value before the old one has been used.
    int err = -ENOENT;
   ^
   fs/sysv/namei.c:159:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = sysv_delete_entry (de, page);
        ^
   fs/sysv/namei.c:219:7: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
     err = -ENOTEMPTY;
         ^
   fs/sysv/namei.c:199:0: note: Variable 'err' is reassigned a value before the old one has been used.
    int err = -ENOENT;
   ^
   fs/sysv/namei.c:219:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = -ENOTEMPTY;
         ^
   fs/sysv/namei.c:219:7: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
     err = -ENOTEMPTY;
         ^
   fs/sysv/namei.c:209:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = -EIO;
         ^
   fs/sysv/namei.c:219:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = -ENOTEMPTY;
         ^
   fs/sysv/namei.c:223:7: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
     err = -ENOENT;
         ^
   fs/sysv/namei.c:219:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = -ENOTEMPTY;
         ^
   fs/sysv/namei.c:223:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = -ENOENT;
         ^
--
>> drivers/md/dm-clone-metadata.c:781:4: warning: Variable 'r' is reassigned a value before the old one has been used. [redundantAssignment]
    r = __flush_dmap(cmd, dmap);
      ^
   drivers/md/dm-clone-metadata.c:748:0: note: Variable 'r' is reassigned a value before the old one has been used.
    int r = -EPERM;
   ^
   drivers/md/dm-clone-metadata.c:781:4: note: Variable 'r' is reassigned a value before the old one has been used.
    r = __flush_dmap(cmd, dmap);
      ^
   drivers/md/dm-clone-metadata.c:863:4: warning: Variable 'r' is reassigned a value before the old one has been used. [redundantAssignment]
    r = __load_bitset_in_core(cmd);
      ^
   drivers/md/dm-clone-metadata.c:856:0: note: Variable 'r' is reassigned a value before the old one has been used.
    int r = -EINVAL;
   ^
   drivers/md/dm-clone-metadata.c:863:4: note: Variable 'r' is reassigned a value before the old one has been used.
    r = __load_bitset_in_core(cmd);
      ^
   drivers/md/dm-clone-metadata.c:893:4: warning: Variable 'r' is reassigned a value before the old one has been used. [redundantAssignment]
    r = __create_persistent_data_structures(cmd, false);
      ^
   drivers/md/dm-clone-metadata.c:884:0: note: Variable 'r' is reassigned a value before the old one has been used.
    int r = -EPERM;
   ^
   drivers/md/dm-clone-metadata.c:893:4: note: Variable 'r' is reassigned a value before the old one has been used.
    r = __create_persistent_data_structures(cmd, false);
      ^
--
>> fs/sysv/super.c:506:17: warning: Variable 'sbi->s_bytesex' is reassigned a value before the old one has been used. [redundantAssignment]
    sbi->s_bytesex = BYTESEX_LE;
                   ^
   fs/sysv/super.c:501:17: note: Variable 'sbi->s_bytesex' is reassigned a value before the old one has been used.
    sbi->s_bytesex = BYTESEX_PDP;
                   ^
   fs/sysv/super.c:506:17: note: Variable 'sbi->s_bytesex' is reassigned a value before the old one has been used.
    sbi->s_bytesex = BYTESEX_LE;
                   ^
--
>> drivers/md/dm-delay.c:85:18: warning: Local variable flush_bios shadows outer function [shadowFunction]
    struct bio_list flush_bios = { };
                    ^
   drivers/md/dm-delay.c:68:13: note: Shadowed declaration
   static void flush_bios(struct bio *bio)
               ^
   drivers/md/dm-delay.c:85:18: note: Shadow variable
    struct bio_list flush_bios = { };
                    ^
--
>> drivers/memstick/core/mspro_block.c:1446:5: warning: Variable 'rc' is reassigned a value before the old one has been used. [redundantAssignment]
    rc = register_blkdev(major, DRIVER_NAME);
       ^
   drivers/memstick/core/mspro_block.c:1444:0: note: Variable 'rc' is reassigned a value before the old one has been used.
    int rc = -ENOMEM;
   ^
   drivers/memstick/core/mspro_block.c:1446:5: note: Variable 'rc' is reassigned a value before the old one has been used.
    rc = register_blkdev(major, DRIVER_NAME);
       ^
>> drivers/nvme/target/fc.c:1729:19: warning: Variable 'fod->data_sg_cnt' is reassigned a value before the old one has been used. [redundantAssignment]
    fod->data_sg_cnt = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
                     ^
   drivers/nvme/target/fc.c:1728:19: note: Variable 'fod->data_sg_cnt' is reassigned a value before the old one has been used.
    fod->data_sg_cnt = nent;
                     ^
   drivers/nvme/target/fc.c:1729:19: note: Variable 'fod->data_sg_cnt' is reassigned a value before the old one has been used.
    fod->data_sg_cnt = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
                     ^
>> drivers/nvme/target/fc.c:1077:2: warning: Address of local auto-variable assigned to a function parameter. [autoVariables]
    *portptr = &newrec->fc_target_port;
    ^
--
>> drivers/nvme/target/loop.c:595:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = nvme_loop_configure_admin_queue(ctrl);
        ^
   drivers/nvme/target/loop.c:584:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -ENOMEM;
        ^
   drivers/nvme/target/loop.c:595:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = nvme_loop_configure_admin_queue(ctrl);
        ^
>> drivers/pci/syscall.c:47:6: warning: Variable 'err' is reassigned a value before the old one has been used. 'break;' missing? [redundantAssignInSwitch]
    err = -EIO;
        ^
   drivers/pci/syscall.c:27:6: note: Variable 'err' is reassigned a value before the old one has been used. 'break;' missing?
    err = -ENODEV;
        ^
   drivers/pci/syscall.c:47:6: note: Variable 'err' is reassigned a value before the old one has been used. 'break;' missing?
    err = -EIO;
        ^
>> drivers/nvme/target/fcloop.c:909:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = fcloop_parse_options(opts, buf);
        ^
   drivers/nvme/target/fcloop.c:899:0: note: Variable 'ret' is reassigned a value before the old one has been used.
    int ret = -ENOMEM;
   ^
   drivers/nvme/target/fcloop.c:909:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = fcloop_parse_options(opts, buf);
        ^
>> drivers/nvme/target/fcloop.c:1397:32: warning: Uninitialized variable: lport [uninitvar]
     ret = __wait_localport_unreg(lport);
                                  ^
>> drivers/nvme/target/fcloop.c:1380:28: warning: Uninitialized variable: nport [uninitvar]
     ret = __remoteport_unreg(nport, rport);
                              ^
--
>> drivers/regulator/wm8994-regulator.c:124:33: warning: Either the condition '!pdata' is redundant or there is possible null pointer dereference: pdata. [nullPointerRedundantCheck]
    int id = pdev->id % ARRAY_SIZE(pdata->ldo);
                                   ^
   drivers/regulator/wm8994-regulator.c:158:6: note: Assuming that condition '!pdata' is not redundant
    if (!pdata || !pdata->ldo[id].init_data || wm8994->dev->of_node) {
        ^
   drivers/regulator/wm8994-regulator.c:124:33: note: Null pointer dereference
    int id = pdev->id % ARRAY_SIZE(pdata->ldo);
                                   ^
>> drivers/sbus/char/uctrl.c:370:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = request_irq(p->irq, uctrl_interrupt, 0, "uctrl", p);
        ^
   drivers/sbus/char/uctrl.c:353:0: note: Variable 'err' is reassigned a value before the old one has been used.
    int err = -ENOMEM;
   ^
   drivers/sbus/char/uctrl.c:370:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = request_irq(p->irq, uctrl_interrupt, 0, "uctrl", p);
        ^
--
>> drivers/scsi/pcmcia/nsp_cs.c:403:19: warning: Variable 'SCpnt->SCp.phase' is reassigned a value before the old one has been used. [redundantAssignment]
    SCpnt->SCp.phase = PH_SELSTART;
                     ^
   drivers/scsi/pcmcia/nsp_cs.c:383:19: note: Variable 'SCpnt->SCp.phase' is reassigned a value before the old one has been used.
    SCpnt->SCp.phase = PH_ARBSTART;
                     ^
   drivers/scsi/pcmcia/nsp_cs.c:403:19: note: Variable 'SCpnt->SCp.phase' is reassigned a value before the old one has been used.
    SCpnt->SCp.phase = PH_SELSTART;
                     ^
>> drivers/scsi/pcmcia/nsp_message.c:46:7: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
     ret = nsp_expect_signal(SCpnt, BUSPHASE_MESSAGE_IN, BUSMON_REQ);
         ^
   drivers/scsi/pcmcia/nsp_message.c:24:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = 16;
        ^
   drivers/scsi/pcmcia/nsp_message.c:46:7: note: Variable 'ret' is reassigned a value before the old one has been used.
     ret = nsp_expect_signal(SCpnt, BUSPHASE_MESSAGE_IN, BUSMON_REQ);
         ^
>> drivers/scsi/qlogicfas408.c:130:26: warning: Variable 'j' is reassigned a value before the old one has been used. [redundantAssignment]
      while (reqlen && !((j = inb(qbase + 8)) & 0x10))
                            ^
   drivers/scsi/qlogicfas408.c:129:6: note: Variable 'j' is reassigned a value before the old one has been used.
      j &= 0xc0;
        ^
   drivers/scsi/qlogicfas408.c:130:26: note: Variable 'j' is reassigned a value before the old one has been used.
      while (reqlen && !((j = inb(qbase + 8)) & 0x10))
                            ^
>> drivers/scsi/qlogicfas408.c:339:4: warning: Variable 'k' is reassigned a value before the old one has been used. [redundantAssignment]
    k = jiffies + WATCHDOG;
      ^
   drivers/scsi/qlogicfas408.c:332:5: note: Variable 'k' is reassigned a value before the old one has been used.
     k = inb(qbase + 5); /* should be 0x10, bus service */
       ^
   drivers/scsi/qlogicfas408.c:339:4: note: Variable 'k' is reassigned a value before the old one has been used.
    k = jiffies + WATCHDOG;
      ^
>> drivers/scsi/esp_scsi.c:1901:8: warning: Local variable i shadows outer variable [shadowVar]
      int i;
          ^
   drivers/scsi/esp_scsi.c:1696:13: note: Shadowed declaration
    int write, i;
               ^
   drivers/scsi/esp_scsi.c:1901:8: note: Shadow variable
      int i;
          ^
   drivers/scsi/esp_scsi.c:1909:8: warning: Local variable i shadows outer variable [shadowVar]
      int i;
          ^
   drivers/scsi/esp_scsi.c:1696:13: note: Shadowed declaration
    int write, i;
               ^
   drivers/scsi/esp_scsi.c:1909:8: note: Shadow variable
      int i;
          ^
--
>> drivers/video/fbdev/bw2.c:331:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = register_framebuffer(info);
        ^
   drivers/video/fbdev/bw2.c:285:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = -ENOMEM;
        ^
   drivers/video/fbdev/bw2.c:331:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = register_framebuffer(info);
        ^
--
>> drivers/video/fbdev/cg14.c:549:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = register_framebuffer(info);
        ^
   drivers/video/fbdev/cg14.c:474:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = -ENOMEM;
        ^
   drivers/video/fbdev/cg14.c:549:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = register_framebuffer(info);
        ^
--
>> drivers/video/fbdev/tcx.c:465:6: warning: Variable 'err' is reassigned a value before the old one has been used. 'break;' missing? [redundantAssignInSwitch]
    err = register_framebuffer(info);
        ^
   drivers/video/fbdev/tcx.c:375:6: note: Variable 'err' is reassigned a value before the old one has been used. 'break;' missing?
    err = -ENOMEM;
        ^
   drivers/video/fbdev/tcx.c:465:6: note: Variable 'err' is reassigned a value before the old one has been used. 'break;' missing?
    err = register_framebuffer(info);
        ^
--
>> drivers/video/fbdev/leo.c:617:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = register_framebuffer(info);
        ^
   drivers/video/fbdev/leo.c:560:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = -ENOMEM;
        ^
   drivers/video/fbdev/leo.c:617:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = register_framebuffer(info);
        ^
--
>> drivers/scsi/sun_esp.c:475:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = esp_sbus_setup_dma(esp, espdma);
        ^
   drivers/scsi/sun_esp.c:461:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = -ENOMEM;
        ^
   drivers/scsi/sun_esp.c:475:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = esp_sbus_setup_dma(esp, espdma);
        ^
--
>> drivers/video/fbdev/grvga.c:400:9: warning: Variable 'retval' is reassigned a value before the old one has been used. [redundantAssignment]
    retval = fb_alloc_cmap(&info->cmap, 256, 0);
           ^
   drivers/video/fbdev/grvga.c:330:0: note: Variable 'retval' is reassigned a value before the old one has been used.
    int retval = -ENOMEM;
   ^
   drivers/video/fbdev/grvga.c:400:9: note: Variable 'retval' is reassigned a value before the old one has been used.
    retval = fb_alloc_cmap(&info->cmap, 256, 0);
           ^

vim +/r +781 drivers/md/dm-clone-metadata.c

   745	
   746	int dm_clone_metadata_commit(struct dm_clone_metadata *cmd)
   747	{
   748		int r = -EPERM;
   749		unsigned long flags;
   750		struct dirty_map *dmap, *next_dmap;
   751	
   752		down_write(&cmd->lock);
   753	
   754		if (cmd->fail_io || dm_bm_is_read_only(cmd->bm))
   755			goto out;
   756	
   757		/* Get current dirty bitmap */
   758		dmap = cmd->current_dmap;
   759	
   760		/* Get next dirty bitmap */
   761		next_dmap = (dmap == &cmd->dmap[0]) ? &cmd->dmap[1] : &cmd->dmap[0];
   762	
   763		/*
   764		 * The last commit failed, so we don't have a clean dirty-bitmap to
   765		 * use.
   766		 */
   767		if (WARN_ON(next_dmap->changed)) {
   768			r = -EINVAL;
   769			goto out;
   770		}
   771	
   772		/* Swap dirty bitmaps */
   773		spin_lock_irqsave(&cmd->bitmap_lock, flags);
   774		cmd->current_dmap = next_dmap;
   775		spin_unlock_irqrestore(&cmd->bitmap_lock, flags);
   776	
   777		/*
   778		 * No one is accessing the old dirty bitmap anymore, so we can flush
   779		 * it.
   780		 */
 > 781		r = __flush_dmap(cmd, dmap);
   782	out:
   783		up_write(&cmd->lock);
   784	
   785		return r;
   786	}
   787	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
