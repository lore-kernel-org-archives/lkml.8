Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99F0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79EA4206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHRDze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:55:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:14937 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgHRDze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:55:34 -0400
IronPort-SDR: hIeQP7Hf9ZpcugHu2h1X4clWwRHZbTBoYtKY3V40A6Bg4iuklE20UnbqLkKQPqmDcrcGHnfWAr
 QaWlbHLefdMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142664613"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="gz'50?scan'50,208,50";a="142664613"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:55:28 -0700
IronPort-SDR: y4wrDn8qdZdQPQW0QFkbBYa4MdR7NRk5YSH+gIzoJ494ZMRfaiyf/JGTfWBmo80ZawM3trxpaR
 MgkuuDf/QP6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="gz'50?scan'50,208,50";a="292637383"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2020 20:55:26 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7sib-0000yV-Az; Tue, 18 Aug 2020 03:55:25 +0000
Date:   Tue, 18 Aug 2020 11:54:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <bwh@kernel.org>
Subject: drivers/scsi/sg.c:1145 sg_ioctl_common() warn: inconsistent returns
 'sfp->rq_list_lock'.
Message-ID: <202008181128.mwASthcZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
commit: d320a9551e394cb2d842fd32d28e9805c2a18fbb compat_ioctl: scsi: move ioctl handling into drivers
date:   8 months ago
config: ia64-randconfig-m031-20200818 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/scsi/sg.c:1145 sg_ioctl_common() warn: inconsistent returns 'sfp->rq_list_lock'.

Old smatch warnings:
drivers/scsi/sg.c:1094 sg_ioctl_common() warn: inconsistent indenting

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d320a9551e394cb2d842fd32d28e9805c2a18fbb
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout d320a9551e394cb2d842fd32d28e9805c2a18fbb
vim +1145 drivers/scsi/sg.c

   912	
   913	static long
   914	sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
   915			unsigned int cmd_in, void __user *p)
   916	{
   917		int __user *ip = p;
   918		int result, val, read_only;
   919		Sg_request *srp;
   920		unsigned long iflags;
   921	
   922		SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
   923					   "sg_ioctl: cmd=0x%x\n", (int) cmd_in));
   924		read_only = (O_RDWR != (filp->f_flags & O_ACCMODE));
   925	
   926		switch (cmd_in) {
   927		case SG_IO:
   928			if (atomic_read(&sdp->detaching))
   929				return -ENODEV;
   930			if (!scsi_block_when_processing_errors(sdp->device))
   931				return -ENXIO;
   932			result = sg_new_write(sfp, filp, p, SZ_SG_IO_HDR,
   933					 1, read_only, 1, &srp);
   934			if (result < 0)
   935				return result;
   936			result = wait_event_interruptible(sfp->read_wait,
   937				(srp_done(sfp, srp) || atomic_read(&sdp->detaching)));
   938			if (atomic_read(&sdp->detaching))
   939				return -ENODEV;
   940			write_lock_irq(&sfp->rq_list_lock);
   941			if (srp->done) {
   942				srp->done = 2;
   943				write_unlock_irq(&sfp->rq_list_lock);
   944				result = sg_new_read(sfp, p, SZ_SG_IO_HDR, srp);
   945				return (result < 0) ? result : 0;
   946			}
   947			srp->orphan = 1;
   948			write_unlock_irq(&sfp->rq_list_lock);
   949			return result;	/* -ERESTARTSYS because signal hit process */
   950		case SG_SET_TIMEOUT:
   951			result = get_user(val, ip);
   952			if (result)
   953				return result;
   954			if (val < 0)
   955				return -EIO;
   956			if (val >= mult_frac((s64)INT_MAX, USER_HZ, HZ))
   957				val = min_t(s64, mult_frac((s64)INT_MAX, USER_HZ, HZ),
   958					    INT_MAX);
   959			sfp->timeout_user = val;
   960			sfp->timeout = mult_frac(val, HZ, USER_HZ);
   961	
   962			return 0;
   963		case SG_GET_TIMEOUT:	/* N.B. User receives timeout as return value */
   964					/* strange ..., for backward compatibility */
   965			return sfp->timeout_user;
   966		case SG_SET_FORCE_LOW_DMA:
   967			/*
   968			 * N.B. This ioctl never worked properly, but failed to
   969			 * return an error value. So returning '0' to keep compability
   970			 * with legacy applications.
   971			 */
   972			return 0;
   973		case SG_GET_LOW_DMA:
   974			return put_user((int) sdp->device->host->unchecked_isa_dma, ip);
   975		case SG_GET_SCSI_ID:
   976			{
   977				sg_scsi_id_t v;
   978	
   979				if (atomic_read(&sdp->detaching))
   980					return -ENODEV;
   981				memset(&v, 0, sizeof(v));
   982				v.host_no = sdp->device->host->host_no;
   983				v.channel = sdp->device->channel;
   984				v.scsi_id = sdp->device->id;
   985				v.lun = sdp->device->lun;
   986				v.scsi_type = sdp->device->type;
   987				v.h_cmd_per_lun = sdp->device->host->cmd_per_lun;
   988				v.d_queue_depth = sdp->device->queue_depth;
   989				if (copy_to_user(p, &v, sizeof(sg_scsi_id_t)))
   990					return -EFAULT;
   991				return 0;
   992			}
   993		case SG_SET_FORCE_PACK_ID:
   994			result = get_user(val, ip);
   995			if (result)
   996				return result;
   997			sfp->force_packid = val ? 1 : 0;
   998			return 0;
   999		case SG_GET_PACK_ID:
  1000			read_lock_irqsave(&sfp->rq_list_lock, iflags);
  1001			list_for_each_entry(srp, &sfp->rq_list, entry) {
  1002				if ((1 == srp->done) && (!srp->sg_io_owned)) {
  1003					read_unlock_irqrestore(&sfp->rq_list_lock,
  1004							       iflags);
  1005					return put_user(srp->header.pack_id, ip);
  1006				}
  1007			}
  1008			read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
  1009			return put_user(-1, ip);
  1010		case SG_GET_NUM_WAITING:
  1011			read_lock_irqsave(&sfp->rq_list_lock, iflags);
  1012			val = 0;
  1013			list_for_each_entry(srp, &sfp->rq_list, entry) {
  1014				if ((1 == srp->done) && (!srp->sg_io_owned))
  1015					++val;
  1016			}
  1017			read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
  1018			return put_user(val, ip);
  1019		case SG_GET_SG_TABLESIZE:
  1020			return put_user(sdp->sg_tablesize, ip);
  1021		case SG_SET_RESERVED_SIZE:
  1022			result = get_user(val, ip);
  1023			if (result)
  1024				return result;
  1025	                if (val < 0)
  1026	                        return -EINVAL;
  1027			val = min_t(int, val,
  1028				    max_sectors_bytes(sdp->device->request_queue));
  1029			mutex_lock(&sfp->f_mutex);
  1030			if (val != sfp->reserve.bufflen) {
  1031				if (sfp->mmap_called ||
  1032				    sfp->res_in_use) {
  1033					mutex_unlock(&sfp->f_mutex);
  1034					return -EBUSY;
  1035				}
  1036	
  1037				sg_remove_scat(sfp, &sfp->reserve);
  1038				sg_build_reserve(sfp, val);
  1039			}
  1040			mutex_unlock(&sfp->f_mutex);
  1041			return 0;
  1042		case SG_GET_RESERVED_SIZE:
  1043			val = min_t(int, sfp->reserve.bufflen,
  1044				    max_sectors_bytes(sdp->device->request_queue));
  1045			return put_user(val, ip);
  1046		case SG_SET_COMMAND_Q:
  1047			result = get_user(val, ip);
  1048			if (result)
  1049				return result;
  1050			sfp->cmd_q = val ? 1 : 0;
  1051			return 0;
  1052		case SG_GET_COMMAND_Q:
  1053			return put_user((int) sfp->cmd_q, ip);
  1054		case SG_SET_KEEP_ORPHAN:
  1055			result = get_user(val, ip);
  1056			if (result)
  1057				return result;
  1058			sfp->keep_orphan = val;
  1059			return 0;
  1060		case SG_GET_KEEP_ORPHAN:
  1061			return put_user((int) sfp->keep_orphan, ip);
  1062		case SG_NEXT_CMD_LEN:
  1063			result = get_user(val, ip);
  1064			if (result)
  1065				return result;
  1066			if (val > SG_MAX_CDB_SIZE)
  1067				return -ENOMEM;
  1068			sfp->next_cmd_len = (val > 0) ? val : 0;
  1069			return 0;
  1070		case SG_GET_VERSION_NUM:
  1071			return put_user(sg_version_num, ip);
  1072		case SG_GET_ACCESS_COUNT:
  1073			/* faked - we don't have a real access count anymore */
  1074			val = (sdp->device ? 1 : 0);
  1075			return put_user(val, ip);
  1076		case SG_GET_REQUEST_TABLE:
  1077			{
  1078				sg_req_info_t *rinfo;
  1079	
  1080				rinfo = kcalloc(SG_MAX_QUEUE, SZ_SG_REQ_INFO,
  1081						GFP_KERNEL);
  1082				if (!rinfo)
  1083					return -ENOMEM;
  1084				read_lock_irqsave(&sfp->rq_list_lock, iflags);
  1085				sg_fill_request_table(sfp, rinfo);
  1086				read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
  1087		#ifdef CONFIG_COMPAT
  1088				if (in_compat_syscall())
  1089					result = put_compat_request_table(p, rinfo);
  1090				else
  1091		#endif
  1092					result = copy_to_user(p, rinfo,
  1093							      SZ_SG_REQ_INFO * SG_MAX_QUEUE);
  1094				result = result ? -EFAULT : 0;
  1095				kfree(rinfo);
  1096				return result;
  1097			}
  1098		case SG_EMULATED_HOST:
  1099			if (atomic_read(&sdp->detaching))
  1100				return -ENODEV;
  1101			return put_user(sdp->device->host->hostt->emulated, ip);
  1102		case SCSI_IOCTL_SEND_COMMAND:
  1103			if (atomic_read(&sdp->detaching))
  1104				return -ENODEV;
  1105			return sg_scsi_ioctl(sdp->device->request_queue, NULL, filp->f_mode, p);
  1106		case SG_SET_DEBUG:
  1107			result = get_user(val, ip);
  1108			if (result)
  1109				return result;
  1110			sdp->sgdebug = (char) val;
  1111			return 0;
  1112		case BLKSECTGET:
  1113			return put_user(max_sectors_bytes(sdp->device->request_queue),
  1114					ip);
  1115		case BLKTRACESETUP:
  1116			return blk_trace_setup(sdp->device->request_queue,
  1117					       sdp->disk->disk_name,
  1118					       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
  1119					       NULL, p);
  1120		case BLKTRACESTART:
  1121			return blk_trace_startstop(sdp->device->request_queue, 1);
  1122		case BLKTRACESTOP:
  1123			return blk_trace_startstop(sdp->device->request_queue, 0);
  1124		case BLKTRACETEARDOWN:
  1125			return blk_trace_remove(sdp->device->request_queue);
  1126		case SCSI_IOCTL_GET_IDLUN:
  1127		case SCSI_IOCTL_GET_BUS_NUMBER:
  1128		case SCSI_IOCTL_PROBE_HOST:
  1129		case SG_GET_TRANSFORM:
  1130		case SG_SCSI_RESET:
  1131			if (atomic_read(&sdp->detaching))
  1132				return -ENODEV;
  1133			break;
  1134		default:
  1135			if (read_only)
  1136				return -EPERM;	/* don't know so take safe approach */
  1137			break;
  1138		}
  1139	
  1140		result = scsi_ioctl_block_when_processing_errors(sdp->device,
  1141				cmd_in, filp->f_flags & O_NDELAY);
  1142		if (result)
  1143			return result;
  1144	
> 1145		return -ENOIOCTLCMD;
  1146	}
  1147	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--DocE+STaALJfprDB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--DocE+STaALJfprDB--
